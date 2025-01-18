using System.Collections;
using System.Collections.Generic;
using UnityEditor.Experimental.GraphView;
using UnityEngine;

public class CombatManager : Singleton<CombatManager>
{
    public bool canBlock = false;

    public void ResolveCombat(AttackMapper playerAttackType, RaycastHit enemyInfo)
    {
        EnemyType enemy = enemyInfo.collider.GetComponent<EnemyType>();
        AttackType enemyAttackType = enemy.attackType;

        Animator animatorEnemy = enemyInfo.collider.GetComponent<Animator>();
        EnemyHealth healthEnemy = enemyInfo.collider.GetComponent<EnemyHealth>();

        if (healthEnemy != null)
        {
            Debug.Log("ko co health");
        }

        if (playerAttackType.attackType == enemyAttackType && canBlock)
        {
            animatorEnemy?.Play("Block");

            BlockDamage(playerAttackType);
            canBlock = false;
            //StartCoroutine("OnBlocked");
        }

        else if ((playerAttackType.attackType == AttackType.Punch && enemyAttackType == AttackType.Kick) ||
                 (playerAttackType.attackType == AttackType.Kick && enemyAttackType == AttackType.Duck) ||
                 (playerAttackType.attackType == AttackType.Duck && enemyAttackType == AttackType.Punch))
        {
            healthEnemy?.TakeDamage();
        }
    }

    void BlockDamage(AttackMapper playerAttackType)
    {
        if (playerAttackType.attackType == AttackType.Punch)
        {
            Player.Instance.controller.animator.Play("BlockPunch");
        }

        else if (playerAttackType.attackType == AttackType.Kick)
        {
            Player.Instance.controller.animator.Play("BlockKick");
        }

        else if (playerAttackType.attackType == AttackType.Duck)
        {
            Player.Instance.controller.animator.Play("BlockDuck");
        }


        Player.Instance.GetComponent<PlayerBlocking>().PlayerIsRepelled();
    }
}
