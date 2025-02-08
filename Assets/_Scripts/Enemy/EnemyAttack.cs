using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyAttack : MonoBehaviour
{
    Animator animator;
    PushingPlayer pushPlayer;
    AttackType enemyType;

    void Start()
    {
        animator = GetComponent<Animator>();
        pushPlayer = GetComponent<PushingPlayer>();
        enemyType = GetComponent<EnemyType>().attackType;
    }

    public void PerformAttack()
    {
        if(!AttackingEnemyManager.Instance.CanAttack(this)) return;

        AttackingEnemyManager.Instance.SetAttackingEnemy(this);
        animator.Play("Attack");
    }

    public void CheckPlayer()
    {
        AttackType playerAttackType = Player.Instance.attackType.type;
        int enemyDirection = MathF.Sign(this.transform.rotation.y);
        int playerDirection = MathF.Sign(Player.Instance.transform.rotation.y);

        if (playerAttackType == enemyType && CombatManager.Instance.playerIsAttacking && enemyDirection == -playerDirection)
        {
            CombatManager.Instance.BlockDamage(playerAttackType);
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
        animator.Play("Block");

        UEventData uEventData = new UEventData();
        UEventDispatcherSingleton.Instance.Invoke<PlayerBlocking>(uEventData);

        if(Player.Instance.health.currentHealth == 1)
        {
            Player.Instance.health.currentHeart = 0;
        }
        
        InGameManager.Instance.lives.UpdateLivesProgress();
    }

    public void DealDamage()
    {
        Player.Instance.health.TakeDamage();
        Player.Instance.health.currentHeart = 0;
        InGameManager.Instance.lives.UpdateLivesProgress();
        InGameManager.Instance.bonusPoint.LosePoint();
        DataEndGame.Instance.beatingStreak = 0;

        pushPlayer.PerformPush();
    }

    IEnumerator RemoveAttacking()
    {
        yield return new WaitForSeconds(0.4f);
        AttackingEnemyManager.Instance.ClearAttackingEnemy(this);
    }
}
