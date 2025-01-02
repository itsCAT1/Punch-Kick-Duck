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


        if (playerAttackType.attackType == enemyAttackType)
        {
            if (canBlock)
            {
                StartCoroutine("OnBlocked");
                Debug.Log("Block");
            }
        }
        else if ((playerAttackType.attackType == AttackType.Punch && enemyAttackType == AttackType.Kick) ||
                 (playerAttackType.attackType == AttackType.Kick && enemyAttackType == AttackType.Duck) ||
                 (playerAttackType.attackType == AttackType.Duck && enemyAttackType == AttackType.Punch))
        {
            Player.Instance.controller.animator?.Play("Hurt");
            Debug.Log("Player attacked");
        }
        else
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
    }
}
