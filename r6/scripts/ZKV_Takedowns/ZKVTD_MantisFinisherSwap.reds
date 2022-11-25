/*
// ZKV_Takedowns by Kvalyr
*/

public static func ZKVLog(const str: script_ref<String>) -> Void {
  LogChannel(n"DEBUG", "ZKVTD: " + str);
}


public final func ZKV_KillTarget(owner: ref<GameObject>, target: wref<GameObject>, bloodPuddle: Bool) -> Void {
    TakedownGameEffectHelper.FillTakedownData(owner, owner, target, n"takedowns", n"kill");
    ScriptedPuppet.SetBloodPuddleSettings(target as ScriptedPuppet, bloodPuddle);
}


@replaceMethod(DamageSystem)
    private final func PlayFinisherGameEffect(const hitEvent: ref<gameHitEvent>, const hasFromFront: Bool, const hasFromBack: Bool) -> Bool {
        let bodyType: CName;
        let bodyTypeVarSetter: ref<AnimWrapperWeightSetter>;
        let finisherName: CName;
        let gameEffectInstance: ref<EffectInstance>;
        let instigator: ref<GameObject>;
        let targetPuppet: ref<gamePuppet>;
        let attackData: ref<AttackData> = hitEvent.attackData;
        if !this.GetFinisherNameBasedOnWeapon(hitEvent, hasFromFront, hasFromBack, finisherName) {
            return false;
        };
        instigator = attackData.GetInstigator();

        // Kv
        let useAerialWorkspot = TweakDBInterface.GetBool(t"ZKVTD.MantisBladesAnimSwap.UseAerial", true);
        let doRandomChoice = TweakDBInterface.GetBool(t"ZKVTD.MantisBladesAnimSwap.RandomChoice", false);

        // Occasionally use aerial takedown as finisher for Mantis Blades
        let finisherEffectSet: CName = n"playFinisher";
        let killTarget: Bool = false;
        let coinToss: Int32;
        ZKVLog(s"useAerialWorkspot: " + useAerialWorkspot + " - doRandomChoice: " + doRandomChoice);

        if useAerialWorkspot {
            if Equals(finisherName, n"Cyb_MantisBlades") || Equals(finisherName, n"Cyb_MantisBlades_Back") {
                if doRandomChoice{
                    coinToss = RandRange(0, 100);
                }else {
                    coinToss = 101;
                }
                ZKVLog(s"coinToss: " + coinToss);
                if coinToss >= 50 {
                    killTarget = true;
                    finisherEffectSet = n"takedowns";
                    if Equals(finisherName, n"Cyb_MantisBlades") {
                        finisherName = n"AerialTakedown_MantisBlades";
                    }else {
                        finisherName = n"AerialTakedown_Back_MantisBlades";
                    };
                };
            };
        };
        // gameEffectInstance = GameInstance.GetGameEffectSystem(GetGameInstance()).CreateEffectStatic(n"playFinisher", finisherName, instigator);
        gameEffectInstance = GameInstance.GetGameEffectSystem(GetGameInstance()).CreateEffectStatic(finisherEffectSet, finisherName, instigator);
        // Kv End

        if !IsDefined(gameEffectInstance) {
            return false;
        };
        AnimationControllerComponent.PushEventToObjAndHeldItems(instigator, n"ForceReady");
        targetPuppet = hitEvent.target as gamePuppet;
        bodyType = targetPuppet.GetBodyType();
        bodyTypeVarSetter = new AnimWrapperWeightSetter();
        bodyTypeVarSetter.key = bodyType;
        bodyTypeVarSetter.value = 1.00;
        instigator.QueueEvent(bodyTypeVarSetter);
        EffectData.SetVector(gameEffectInstance.GetSharedData(), GetAllBlackboardDefs().EffectSharedData.position, hitEvent.target.GetWorldPosition());
        EffectData.SetEntity(gameEffectInstance.GetSharedData(), GetAllBlackboardDefs().EffectSharedData.entity, hitEvent.target);
        gameEffectInstance.Run();
        AnimationControllerComponent.PushEventToObjAndHeldItems(instigator, n"ForceReady");
        this.SetCameraContext(instigator, n"WorkspotLocked");
        this.SetGameplayCameraParameters(instigator, "cameraFinishers");

        // Kv
        if killTarget{
            // Add kill effect separately as CDPR's finishers and takedowns handle the kill effect differently
            ZKV_KillTarget(instigator, hitEvent.target, true);
        }
        // Kv End

        return true;
    }