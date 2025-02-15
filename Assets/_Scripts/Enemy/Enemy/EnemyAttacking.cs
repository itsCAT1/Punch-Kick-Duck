using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyAttacking : MonoBehaviour
{
    Enemy enemy;
    PushingPlayer pushPlayer;
    AttackType enemyType;

    void Start()
    {
        enemy = GetComponent<Enemy>();
        pushPlayer = GetComponent<PushingPlayer>();
        enemyType = GetComponent<EnemyType>().attackType;
    }

    public void PerformAttack()
    {
        enemy.animator.Play("Attack");
    }

    public void CheckPlayer()
    {
        AttackType playerAttackType = Player.Instance.attackType.type;
        int enemyDirection = MathF.Sign(this.transform.rotation.y);
        int playerDirection = MathF.Sign(Player.Instance.transform.rotation.y);

        if (playerAttackType == enemyType && CombatManager.Instance.playerIsAttacking && enemyDirection == -playerDirection)
        {
            BlockDamage();
        }
        else
        {
            DealDamage();
        }

        StartCoroutine(RemoveAttacking());
    }

    void BlockDamage()
    {
        CombatManager.Instance.BlockDamage(Player.Instance.attackType.type);

        UEventData uEventData = new UEventData();
        UEventDispatcherSingleton.Instance.Invoke<PlayerBlocking>(uEventData);

        enemy.executer.SetCurrentState("Block");
    }

    public void DealDamage()
    {
        Player.Instance.health.TakeDamage();
        CombatManager.Instance.LosePoint();

        pushPlayer.PerformPush();
    }

    IEnumerator RemoveAttacking()
    {
        yield return new WaitForSeconds(0.4f);
        AttackingEnemyManager.Instance.ClearAttackingEnemy(this.gameObject);
    }
}
