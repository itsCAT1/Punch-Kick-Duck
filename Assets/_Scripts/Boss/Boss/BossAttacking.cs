using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BossAttacking : MonoBehaviour
{
    Boss boss;
    PushingPlayer pushPlayer;


    void Start()
    {
        boss = GetComponent<Boss>();
        pushPlayer = GetComponent<PushingPlayer>();
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
        CombatManager.Instance.BlockDamage(Player.Instance.attackType.type);

        UEventData uEventData = new UEventData();
        UEventDispatcherSingleton.Instance.Invoke<PlayerBlocking>(uEventData);

        boss.executer.SetCurrentState("Block");
    }

    public void DealDamage()
    {
        Player.Instance.health.TakeDamage();
        DataPointManager.Instance.LosePoint();

        pushPlayer.PerformPush();
    }
}
