using System.Collections;
using System.Collections.Generic;
using UnityEditor.Experimental.GraphView;
using UnityEngine;

public class CombatManager : Singleton<CombatManager>
{
    public bool playerIsAttacking = false;

    public void DealtDamageEnemy(RaycastHit enemyInfo)
    {
        AttackType playerAttackType = Player.Instance.attackType.type;
        AttackType enemyAttackType = enemyInfo.collider.GetComponent<EnemyType>().attackType;

        EnemyHealth healthEnemy = enemyInfo.collider.GetComponent<EnemyHealth>();
        EnemyAttack attackEnemy = enemyInfo.collider.GetComponent<EnemyAttack>();

        if ((playerAttackType == AttackType.Punch && enemyAttackType == AttackType.Kick) ||
            (playerAttackType == AttackType.Kick && enemyAttackType == AttackType.Duck) ||
            (playerAttackType == AttackType.Duck && enemyAttackType == AttackType.Punch))
        {
            healthEnemy?.TakeDamage();
            StartCoroutine(ContinueAttack(attackEnemy));

            AddPoint();
        }
    }

    public void BlockDamage(AttackType playerAttackType)
    {
        if (playerAttackType == AttackType.Punch)
        {
            Player.Instance.controller.animator.Play("BlockPunch");
        }

        else if (playerAttackType == AttackType.Kick)
        {
            Player.Instance.controller.animator.Play("BlockKick");
        }

        else if (playerAttackType == AttackType.Duck)
        {
            Player.Instance.controller.animator.Play("BlockDuck");
        }


        Player.Instance.GetComponent<PlayerIsPushed>().PlayerIsRepelled();
    }

    IEnumerator ContinueAttack(EnemyAttack attackEnemy)
    {
        yield return new WaitForSeconds(2f);
        AttackingEnemyManager.Instance.ClearAttackingEnemy(attackEnemy);
    }

    void AddPoint()
    {
        Player.Instance.health.GainHeart();
        InGameManager.Instance.bonusPoint.GainPoint();
        DataInGame.Instance.score++;
        DataEndGame.Instance.beatingStreak++;
        UpdateBestStreak();
    }

    void UpdateBestStreak()
    {
        if(DataEndGame.Instance.beatingStreak >= DataEndGame.Instance.bestStreak)
        {
            DataEndGame.Instance.bestStreak = DataEndGame.Instance.beatingStreak;
        }
    }
}
