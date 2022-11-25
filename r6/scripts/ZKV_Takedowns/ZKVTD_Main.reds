/*
// ZKV_Takedowns by Kvalyr

// TODO
* Configurability
    * Add a mod settings UI

// Known issues:
* Weapon in hand during aerial takedowns
    * Not a huge problem. Looks better, IMO.

// Untested:
* Non-mantis arm cyberware

*/

public static func ZKVLog(const str: script_ref<String>) -> Void {
  LogChannel(n"DEBUG", "ZKVTD: " + str);
}


@replaceMethod(TakedownUtils)
    public final static func TakedownActionNameToEnum(actionName: CName) -> ETakedownActionType {
        // ZKVLog(s"ZKV - TakedownActionNameToEnum() - actionName: " + NameToString(actionName));
        switch actionName {
            case n"GrappleFailed":
                return ETakedownActionType.GrappleFailed;
            case n"GrappleTarget":
                return ETakedownActionType.Grapple;
            case n"Takedown":
                return ETakedownActionType.Takedown;
            case n"TakedownNonLethal":
                return ETakedownActionType.TakedownNonLethal;
            case n"TakedownNetrunner":
                return ETakedownActionType.TakedownNetrunner;
            case n"TakedownMassiveTarget":
                return ETakedownActionType.TakedownMassiveTarget;
            case n"LeapToTarget":
                return ETakedownActionType.LeapToTarget;
            case n"AerialTakedown":
                return ETakedownActionType.AerialTakedown;
            case n"Struggle":
                return ETakedownActionType.Struggle;
            case n"BreakFree":
                return ETakedownActionType.BreakFree;
            case n"TargetDead":
                return ETakedownActionType.TargetDead;
            case n"KillTarget":
                return ETakedownActionType.KillTarget;
            case n"SpareTarget":
                return ETakedownActionType.SpareTarget;
            case n"ForceShove":
                return ETakedownActionType.ForceShove;
            case n"BossTakedown":
                return ETakedownActionType.BossTakedown;

            // Kv
            case n"Kv_MeleeTakedown":
                // ZKVLog(s"ZKV - TakedownActionNameToEnum() - actionName: " + NameToString(actionName));
                // TODO: Need to reuse one of the existing types above and differentiate somehow else
                // return ETakedownActionType.LeapToTarget; // DEBUG: -> AerialTakedown
                return ETakedownActionType.KillTarget;
            // Kv End

            default:
        };
        return ETakedownActionType.None;
    }


@wrapMethod(ScriptedPuppetPS)
    public final const func GetValidChoices(actions: array<wref<ObjectAction_Record>>, context: GetActionsContext, objectActionsCallbackController: wref<gameObjectActionsCallbackController>, checkPlayerQuickHackList: Bool, out choices: array<InteractionChoice>) -> Void {
        ArrayPush(actions, TweakDBInterface.GetObjectActionRecord(t"Takedown.Kv_MeleeTakedown"));
        wrappedMethod(actions, context, objectActionsCallbackController, checkPlayerQuickHackList, choices);
    }


public final static func ZKV_GetActiveWeaponType(owner: ref<GameObject>) -> gamedataItemType {
    let weaponType: gamedataItemType;
    // TODO: Validation
    weaponType = TweakDBInterface.GetWeaponItemRecord(ItemID.GetTDBID(ScriptedPuppet.GetWeaponRight(owner).GetItemID())).ItemType().Type();
    return weaponType;
}


public final static func ZKV_IsMantisBladesActive(owner: ref<GameObject>) -> Bool {
    return Equals(ZKV_GetActiveWeaponType(owner), gamedataItemType.Cyb_MantisBlades);
}


// Modify this method to stop it from force-unequipping weapons
// TODO: Find a way to do this by wrapping the method instead of replacing the whole thing?
// TODO: Continue to force-unequip weapons for grapple takedowns?
@replaceMethod(TakedownExecuteTakedownEvents)
    public func OnEnter(stateContext: ref<StateContext>, scriptInterface: ref<StateGameScriptInterface>) -> Void {
        let actionName: CName;
        let weaponType: gamedataItemType;
        if TakedownUtils.ShouldForceTakedown(scriptInterface) {
            actionName = n"TakedownNonLethal";
        } else {
            actionName = this.stateMachineInitData.actionName;
        };
        if Equals(this.GetTakedownAction(stateContext), ETakedownActionType.LeapToTarget) {
            actionName = n"AerialTakedown";
        };
        this.UpdateCameraParams(stateContext, scriptInterface);
        this.SetGameplayCameraParameters(scriptInterface, "cameraTakedowns");
        weaponType = TweakDBInterface.GetWeaponItemRecord(ItemID.GetTDBID(ScriptedPuppet.GetWeaponRight(scriptInterface.executionOwner).GetItemID())).ItemType().Type();
        // Kv
        // if NotEquals(weaponType, gamedataItemType.Cyb_MantisBlades) {
        //     this.ForceTemporaryWeaponUnequip(stateContext, scriptInterface, true);
        // };
        // Kv End
        TakedownUtils.SetTakedownAction(stateContext, TakedownUtils.TakedownActionNameToEnum(actionName));
        this.SelectSyncedAnimationAndExecuteAction(stateContext, scriptInterface, scriptInterface.executionOwner, this.stateMachineInitData.target, actionName);
        this.SetLocomotionParameters(stateContext, scriptInterface);
        this.SetBlackboardIntVariable(scriptInterface, GetAllBlackboardDefs().PlayerStateMachine.Takedown, EnumInt(gamePSMTakedown.Takedown));
        if !scriptInterface.HasStatFlag(gamedataStatType.CanTakedownSilently) {
            this.TriggerNoiseStim(scriptInterface.executionOwner, TakedownUtils.TakedownActionNameToEnum(actionName));
        };
        if Equals(this.GetTakedownAction(stateContext), ETakedownActionType.TakedownNonLethal) && stateContext.GetConditionBool(n"CrouchToggled") {
            scriptInterface.SetAnimationParameterFloat(n"crouch", 1.00);
        };
        GameInstance.GetRazerChromaEffectsSystem(scriptInterface.GetGame()).PlayAnimation(n"Takedown", false);
        GameInstance.GetTelemetrySystem(scriptInterface.GetGame()).LogTakedown(actionName, this.stateMachineInitData.target);
    }


// // Modify this method to stop it from force-unequipping weapons
// // TODO: Continue to force-unequip weapons for grapple takedowns?
// @replaceMethod(LocomotionTakedownEvents)
//     protected final func ForceTemporaryWeaponUnequip(stateContext: ref<StateContext>, scriptInterface: ref<StateGameScriptInterface>, value: Bool) -> Void {

//         if Equals(this.GetTakedownAction(stateContext), ETakedownActionType.LeapToTarget) {
//         // Kv
//         // stateContext.SetPermanentBoolParameter(n"forcedTemporaryUnequip", value, true);
//         // Kv End
//         return;
//     }


public final static func ZKV_Takedowns_LethalityEffectByWeapon(weaponType: gamedataItemType, aerial: Bool) -> CName {
    let unconsciousTag: CName = n"setUnconscious";
    if aerial {
        unconsciousTag = n"setUnconsciousAerialTakedown";
    };
    switch weaponType {
        // TODO: Can switch cases just fall through in this lang?
        case gamedataItemType.Wea_Fists:
            return unconsciousTag;
        case gamedataItemType.Wea_OneHandedClub:
            return unconsciousTag;
        case gamedataItemType.Wea_TwoHandedClub:
            return unconsciousTag;
        case gamedataItemType.Cyb_StrongArms:
            return unconsciousTag;
        default:
            return n"kill";
    };
    return n"kill";
}


public final static func ZKV_Takedowns_GetRandomFromArray(workspots: array<CName>) -> CName {
    let randIndex: Int32;
    let numWorkspots: Int32 = ArraySize(workspots);
    switch numWorkspots {
        case 0:
            ZKVLog(s"Empty array of takedown workspots!");
            return n"finisher_default";
        case 1:
            return workspots[0];
        default:
            randIndex = RandRange(0, numWorkspots - 1);
            return workspots[randIndex];
    };
}

public final static func ZKV_Takedowns_GetTDBIDPrefixForWeaponType(weaponType: gamedataItemType) -> String{
    // TODO: Use an enum for this instead?
    let weaponTypeStr: String = ToString(weaponType);
    return s"ZKVTD.MeleeTakedownAnims." + weaponTypeStr;
}

public final static func ZKV_Takedowns_GetAnimCountForWeapon(weaponType: gamedataItemType, isTakedown: Bool) -> Int32{
    let prefix: String = ZKV_Takedowns_GetTDBIDPrefixForWeaponType(weaponType);
    let countStr: String;
    let count: Int32;
    let countKey: String;
    if isTakedown{
        countKey = prefix + ".countTakedowns";
    }else {
        countKey = prefix + ".countFinishers";
    };
    countStr = TweakDBInterface.GetString(TDBID.Create(countKey), s"0");
    count = StringToInt(countStr);
    return count;
}

public final static func ZKV_Takedowns_GetAnimsForWeapon(weaponType: gamedataItemType, isTakedown: Bool, count: Int32) -> array<CName>{
    let prefix: String = ZKV_Takedowns_GetTDBIDPrefixForWeaponType(weaponType);
    let animKey: TweakDBID;
    let animString: String;
    let animArray: array<CName>;
    let i: Int32;
    if isTakedown{
        prefix = prefix + ".takedown";
    }else {
        prefix = prefix + ".finisher";
    };
    // ZKVLog(s"ZKV_Takedowns_GetAnimsForWeapon - weaponType: " + ToString(weaponType) + " - isTakedown: " + ToString(isTakedown) + " - count: " + count + " - prefix: " + prefix);

    if count < 1 {
        ZKVLog(s"ZKV_Takedowns_GetAnimsForWeapon - Returning empty anim array! - weaponType: " + ToString(weaponType) + " - isTakedown: " + ToString(isTakedown) + " - count: " + ToString(count));
        return animArray;
    }

    i = 0;
    while i < count {
        animKey = TDBID.Create(prefix + ToString(i));
        animString = TweakDBInterface.GetString(animKey, s"");
        if NotEquals(animString, ""){
            ArrayPush(animArray, StringToName(animString));
        };
        i += 1;
    };
    return animArray;
}


public final static func ZKV_IsEffectTagInEffectSet(activator: wref<GameObject>, effectSetName: CName, effectTag: CName) -> Bool {
    return GameInstance.GetGameEffectSystem(activator.GetGame()).HasEffect(effectSetName, effectTag);
}

public final static func ZKV_Takedowns_GetBestEffectSetForEffectTag(activator: wref<GameObject>, effectTag: CName, out effectSet: CName) -> Bool{
    // TODO: Get a dynamic list of effectSets from lua & TweakDB instead of hardcoding these
    let finisherEffectSet: CName = n"playFinisher";
    let takedownEffectSet: CName = n"takedowns";
    let zkvtdEffectSet: CName = n"zkv_takedowns";

    // DEBUG
    // let effectInSet_zkvtd: Bool = ZKV_IsEffectTagInEffectSet(activator, zkvtdEffectSet, effectTag);
    // let effectInSet_finishers: Bool = ZKV_IsEffectTagInEffectSet(activator, finisherEffectSet, effectTag);
    // let effectInSet_takedowns: Bool = ZKV_IsEffectTagInEffectSet(activator, takedownEffectSet, effectTag);
    // ZKVLog(s"ZKV_Takedowns_DoFinisherByWeaponType - effectTag: " + NameToString(effectTag) + " - effectInSet_zkvtd: " + effectInSet_zkvtd);
    // ZKVLog(s"ZKV_Takedowns_DoFinisherByWeaponType - effectTag: " + NameToString(effectTag) + " - effectInSet_finishers: " + effectInSet_finishers);
    // ZKVLog(s"ZKV_Takedowns_DoFinisherByWeaponType - effectTag: " + NameToString(effectTag) + " - effectInSet_takedowns: " + effectInSet_takedowns);
    // DEBUG

    // Prefer ZKVTD effectSet
    if ZKV_IsEffectTagInEffectSet(activator, zkvtdEffectSet, effectTag) {
        effectSet = zkvtdEffectSet;
        return true;
    }

    // Fall back to CDPR finishers/takedowns effectSets if absent from ZKVTD
    if ZKV_IsEffectTagInEffectSet(activator, finisherEffectSet, effectTag) {
        effectSet = finisherEffectSet;
        return true;
    }
    if ZKV_IsEffectTagInEffectSet(activator, takedownEffectSet, effectTag) {
        effectSet = takedownEffectSet;
        return true;
    }

    // If we've reached this point, the effectTag isn't present in any of our known effectSets - This is a bad time.
    ZKVLog(s"ERROR: effectTag not found in any known effectSets: " + NameToString(effectTag));

    return false;
}

public final static func ZKV_Takedowns_DoFinisherByWeaponType(scriptInterface: ref<StateGameScriptInterface>, owner: ref<GameObject>, target: ref<GameObject>, weaponType: gamedataItemType, katanaForBlades: Bool) -> CName {
    let countFinishers: Int32 = ZKV_Takedowns_GetAnimCountForWeapon(weaponType, false);
    let countTakedowns: Int32 = ZKV_Takedowns_GetAnimCountForWeapon(weaponType, true);
    let totalAnimCount: Int32 = countFinishers + countTakedowns;
    let effectTag: CName;
    let effectSet: CName = n"playFinisher";
    let randIndex: Int32;
    let randMax: Int32;
    let takedownsThreshold: Int32;
    let animArray_finishers: array<CName>;
    let animArray_takedowns: array<CName>;

    // ZKVLog(s"ZKV_Takedowns_DoFinisherByWeaponType - weaponType: " + ToString(weaponType) + " - countFinishers: " + countFinishers + " - countTakedowns: " + countTakedowns);

    if totalAnimCount < 1 {
        return n"finisher_default";
    }

    // Randomize
    randMax = totalAnimCount * 100;
    randIndex = RandRange(0, randMax);
    takedownsThreshold = countFinishers * 100;

    if countTakedowns < 1{
        takedownsThreshold = randMax + 1;
        // ZKVLog(s"ZKV_Takedowns_DoFinisherByWeaponType - No Takedowns! - weaponType: " + ToString(weaponType) + " - takedownsThreshold: " + takedownsThreshold);
    }
    else{
        animArray_takedowns = ZKV_Takedowns_GetAnimsForWeapon(weaponType, true, countTakedowns);
    };

    if countFinishers < 1{
        takedownsThreshold = 0;
        // ZKVLog(s"ZKV_Takedowns_DoFinisherByWeaponType - No Finishers! - weaponType: " + ToString(weaponType) + " - takedownsThreshold: " + takedownsThreshold);
    }
    else{
        animArray_finishers = ZKV_Takedowns_GetAnimsForWeapon(weaponType, false, countFinishers);
    };

    // ZKVLog(s"ZKV_Takedowns_DoFinisherByWeaponType - randMax: " + randMax + " - takedownsThreshold: " + takedownsThreshold + " - randIndex: " + randIndex);

    if randIndex >= takedownsThreshold {
        effectTag = ZKV_Takedowns_GetRandomFromArray(animArray_takedowns);
    }
    else{
        effectTag = ZKV_Takedowns_GetRandomFromArray(animArray_finishers);
    }

    // Get the best effectSet for the requested effectTag, or fall back to default
    if !ZKV_Takedowns_GetBestEffectSetForEffectTag(owner, effectTag, effectSet){
        ZKVLog(s"ERROR: Failed to get effectSet. Falling back to default. effectTag: " + NameToString(effectTag));
        effectSet = n"playFinisher";
        effectTag = n"finisher_default";
    }

    ZKVLog(s"ZKV_Takedowns_DoFinisherByWeaponType - effectSet: " + NameToString(effectSet) + " - effectTag:" + NameToString(effectTag));

    TakedownGameEffectHelper.FillTakedownData(scriptInterface.executionOwner, owner, target, effectSet, effectTag);
    return effectTag;
}


@replaceMethod(LocomotionTakedownEvents)
    protected final func SelectSyncedAnimationAndExecuteAction(stateContext: ref<StateContext>, scriptInterface: ref<StateGameScriptInterface>, owner: ref<GameObject>, target: ref<GameObject>, action: CName) -> Void {
        let effectTag: CName;
        let syncedAnimName: CName;
        let dataTrackingEvent: ref<TakedownActionDataTrackingRequest> = new TakedownActionDataTrackingRequest();
        let gameEffectName: CName = n"takedowns";
        // Kv: Changes
        // gameEffectName: Refers to effectSet file: n"takedowns" -> `takedowns.es`
        // effectTag: Refers to specific entry tag in takedowns.es (effectSet) file (specified by gameEffectName)
        // syncedAnimName: Refers to effectExecutor entry by tag in [takedowns.es].effects.[entry].Tag
        // ZKVLog(s"ZKVTEST - action: " + NameToString(action));
        // Kv: End
        switch this.GetTakedownAction(stateContext) {
            case ETakedownActionType.GrappleFailed:
                TakedownGameEffectHelper.FillTakedownData(scriptInterface.executionOwner, owner, target, gameEffectName, action, "");
                break;
            case ETakedownActionType.TargetDead:
                syncedAnimName = n"grapple_sync_death";
                break;
            case ETakedownActionType.BreakFree:
                syncedAnimName = n"grapple_sync_recover";
                break;
            case ETakedownActionType.Takedown:
                syncedAnimName = this.SelectRandomSyncedAnimation(stateContext);
                effectTag = n"kill";
                (target as NPCPuppet).SetMyKiller(owner);
                break;
            case ETakedownActionType.TakedownNonLethal:
                if stateContext.GetConditionBool(n"CrouchToggled") {
                    syncedAnimName = n"grapple_sync_nonlethal_crouch";
                } else {
                    syncedAnimName = this.SelectRandomSyncedAnimation(stateContext);
                };
                effectTag = n"setUnconscious";
                break;
            case ETakedownActionType.TakedownNetrunner:
                syncedAnimName = n"personal_link_takedown_01";
                effectTag = n"setUnconsciousTakedownNetrunner";
                break;
            case ETakedownActionType.TakedownMassiveTarget:
                TakedownGameEffectHelper.FillTakedownData(scriptInterface.executionOwner, owner, target, gameEffectName, action, "");
                effectTag = n"setUnconsciousTakedownMassiveTarget";
                break;
            case ETakedownActionType.AerialTakedown:
                // Kv: Changes
                let aerialTakedownWorkspot: CName = this.SelectAerialTakedownWorkspot(scriptInterface, owner, target, true, true, false, false, action);
                TakedownGameEffectHelper.FillTakedownData(scriptInterface.executionOwner, owner, target, gameEffectName, aerialTakedownWorkspot);
                // Kv: Bugfix for visually-lethal Mantis Blades aerial takedown added in 1.5 not killing the target
                // TODO: Make this optional?
                if ZKV_IsMantisBladesActive(owner) {
                    effectTag = n"kill";
                    (target as NPCPuppet).SetMyKiller(owner);
                }else {
                    effectTag = n"setUnconsciousAerialTakedown";
                };
                // ZKVLog("ETakedownActionType.AerialTakedown - AerialTakedown - effectTag: " + NameToString(effectTag) + " - aerialTakedownWorkspot: " + NameToString(aerialTakedownWorkspot));
                // Kv: End Changes
                break;

            // Kv
            // Repurpose unused KillTarget enumValue as Melee-weapon-takedown
            case ETakedownActionType.KillTarget:
                effectTag = ZKV_Takedowns_LethalityEffectByWeapon(ZKV_GetActiveWeaponType(owner), false);
                let zkv_workspot: CName = ZKV_Takedowns_DoFinisherByWeaponType(scriptInterface, owner, target, ZKV_GetActiveWeaponType(owner), true);
                if Equals(effectTag, n"kill"){
                    (target as NPCPuppet).SetMyKiller(owner);
                }
                // ZKVLog("ETakedownActionType.KillTarget - effectTag: " + NameToString(effectTag) + " - zkv_workspot: " + NameToString(zkv_workspot));
                break;
            // Kv End

            case ETakedownActionType.BossTakedown:
                TakedownGameEffectHelper.FillTakedownData(scriptInterface.executionOwner, owner, target, gameEffectName, this.SelectSyncedAnimationBasedOnPhase(stateContext, target), "");
                effectTag = this.SetEffectorBasedOnPhase(stateContext);
                syncedAnimName = this.GetSyncedAnimationBasedOnPhase(stateContext);
                StatusEffectHelper.ApplyStatusEffect(target, t"BaseStatusEffect.BossTakedownCooldown");
                target.GetTargetTrackerComponent().AddThreat(owner, true, owner.GetWorldPosition(), 1.00, 10.00, false);
                break;
            case ETakedownActionType.ForceShove:
                syncedAnimName = n"grapple_sync_shove";
                break;
            default:
                syncedAnimName = n"grapple_sync_kill";
                effectTag = n"kill";
        };

    if IsNameValid(syncedAnimName) && IsDefined(owner) && IsDefined(target) {
        if this.IsTakedownWeapon(stateContext, scriptInterface) {
            this.FillAnimWrapperInfoBasedOnEquippedItem(scriptInterface, false);
        };
        this.PlayExitAnimation(scriptInterface, owner, target, syncedAnimName);
    };
    dataTrackingEvent.eventType = this.GetTakedownAction(stateContext);
    scriptInterface.GetScriptableSystem(n"DataTrackingSystem").QueueRequest(dataTrackingEvent);
    this.DefeatTarget(stateContext, scriptInterface, owner, target, gameEffectName, effectTag);
  }
