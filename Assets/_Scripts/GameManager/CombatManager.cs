using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CombatManager : Singleton<CombatManager>
{
    public bool canBlock = false;

    public void ResolveCombat(AttackMapper playerAttackType, RaycastHit enemyInfo)
    {
        EnemyType enemy = enemyInfo.collider.GetComponent<EnemyType>();
        AttackType enemyAttackType = enemy.attackType;

        Animator animatorEnemy = enemyInfo.collider.GetComponent<Animator>();


        if (playerAttackType.attackType == enemyAttackType && canBlock)
        {
            animatorEnemy?.Play("Block");

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

            StartCoroutine("OnBlocked");
        }
        else if ((playerAttackType.attackType == AttackType.Punch && enemyAttackType == AttackType.Duck) ||
                 (playerAttackType.attackType == AttackType.Kick && enemyAttackType == AttackType.Punch) ||
                 (playerAttackType.attackType == AttackType.Duck && enemyAttackType == AttackType.Kick))
        {
            animatorEnemy?.Play("Hurt");
            Debug.Log("Enemy attacked");
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
