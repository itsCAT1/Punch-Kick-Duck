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
        Health healthEnemy = enemyInfo.collider.GetComponent<Health>();

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
            animatorEnemy?.Play("Hurt");
            healthEnemy?.TakeDamage();
            Debug.Log("Enemy attacked");
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
    }

    IEnumerator OnBlocked()
    {
        Time.timeScale = 0;
        yield return new WaitForSecondsRealtime(1);
        Time.timeScale = 1;
        canBlock = false;
    }
}
