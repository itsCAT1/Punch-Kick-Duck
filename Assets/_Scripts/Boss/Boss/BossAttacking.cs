using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BossAttacking : MonoBehaviour
{
    PushHandler pushPlayer;


    void Start()
    {
        pushPlayer = GetComponent<PushHandler>();
    }

    public void CheckPlayer()
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
            DealDamage();
        }
    }

    void BlockDamage()
    {
        Player.Instance.block.BlockDamage();

        UEventData uEventData = new UEventData();
        UEventDispatcherSingleton.Instance.Invoke<PlayerBlocking>(uEventData);
        Boss.Instance.executer.SetCurrentState("Block");

    }

    public void DealDamage()
    {
        Player.Instance.health.TakeDamage();

        pushPlayer.PerformPushPlayer();
    }
}
