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

        if ((playerAttackType == AttackType.Punch && enemyAttackType == AttackType.Kick) ||
            (playerAttackType == AttackType.Kick && enemyAttackType == AttackType.Duck) ||
            (playerAttackType == AttackType.Duck && enemyAttackType == AttackType.Punch))
        {
            healthEnemy?.TakeDamage();
            DataPointManager.Instance.GainPoint();
        }
    }

    public void DealtDamageBoss()
    {
        AttackType playerAttackType = Player.Instance.attackType.type;
        AttackType bossAttackType = Boss.Instance.attackType.type;

        if ((playerAttackType == AttackType.Punch && bossAttackType == AttackType.Kick) ||
            (playerAttackType == AttackType.Kick && bossAttackType == AttackType.Duck) ||
            (playerAttackType == AttackType.Duck && bossAttackType == AttackType.Punch))
        {
            Boss.Instance.executer.SetCurrentState("Hurt");
            DataPointManager.Instance.GainPoint();
        }
    }

    public void BlockDamage(AttackType playerAttackType)
    {
        if (playerAttackType == AttackType.Punch)
        {
            Player.Instance.animator.Play("BlockPunch");
        }

        else if (playerAttackType == AttackType.Kick)
        {
            Player.Instance.animator.Play("BlockKick");
        }

        else if (playerAttackType == AttackType.Duck)
        {
            Player.Instance.animator.Play("BlockDuck");
        }
        Player.Instance.GetComponent<PlayerOnBlocking>().PlayerIsRepelled();
    }

    
}
