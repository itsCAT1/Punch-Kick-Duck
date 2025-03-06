using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DG.Tweening;

public class BossAttacking : MonoBehaviour
{
    PushHandler pushPlayer;
    public bool canDealDamage;

    public GameObject hitVFXPrefab;
    public Transform[] hitPosition;
    Transform currentHitPosition;

    void Start()
    {
        pushPlayer = GetComponent<PushHandler>();
    }

    public void ResolveAttack()
    {
        AttackType playerAttackType = Player.Instance.attackType.type;
        AttackType bossAttackType = Boss.Instance.attackType.type;
        int bossDirection = MathF.Sign(this.transform.rotation.y);
        int playerDirection = MathF.Sign(Player.Instance.transform.rotation.y);

        if (playerAttackType == bossAttackType && CombatManager.Instance.playerIsAttacking && bossDirection == -playerDirection)
        {
            BlockDamage();
        }
        else
        {
            if(canDealDamage) DealDamage();
        }
    }

    void BlockDamage()
    {
        Player.Instance.executer.SetCurrentState("Block");

        UEventData uEventData = new UEventData();
        UEventDispatcherSingleton.Instance.Invoke<PlayerBlocking>(uEventData);
        Boss.Instance.executer.SetCurrentState("Block");

    }

    public void DealDamage()
    {
        Player.Instance.health.TakeDamage();

        CreateHitEffect();
        pushPlayer.PerformPushPlayer();
    }

    public void CreateHitEffect()
    {
        if (Boss.Instance.attackType.type == AttackType.Punch) currentHitPosition = hitPosition[0];
        else if (Boss.Instance.attackType.type == AttackType.Kick) currentHitPosition = hitPosition[1];
        else if (Boss.Instance.attackType.type == AttackType.Duck) currentHitPosition = hitPosition[2];

        Instantiate(hitVFXPrefab, currentHitPosition.position, Quaternion.identity);
    }
}
