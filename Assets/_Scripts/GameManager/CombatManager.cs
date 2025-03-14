using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CombatManager : Singleton<CombatManager>
{
    public bool playerIsAttacking = false;
    public bool inBossArea = false;

    public void DealtDamageEnemy(RaycastHit enemyInfo)
    {
        AttackType playerAttackType = Player.Instance.attackType.type;
        AttackType enemyAttackType = enemyInfo.collider.GetComponent<EnemyType>().attackType;

        EnemyHealth healthEnemy = enemyInfo.collider.GetComponent<EnemyHealth>();

        if ((playerAttackType == AttackType.Punch && enemyAttackType == AttackType.Kick) ||
            (playerAttackType == AttackType.Kick && enemyAttackType == AttackType.Duck) ||
            (playerAttackType == AttackType.Duck && enemyAttackType == AttackType.Punch))
        {

            var currentState = Player.Instance.executer.GetCurrentState().Name.ToString();
            if (currentState == "Hurt" || currentState == "Dead") return;

            healthEnemy?.TakeDamage();
            Player.Instance.dealDamage.CreateHitEffect();

            DataPointManager.Instance.GainPoint();

            if (ConditionManger.Instance.currentState == GameState.Tutorial)
            {
                TutorialHandler.Instance.UpdateTutorial(enemyAttackType);
            }
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
            var currentState = Player.Instance.executer.GetCurrentState().Name.ToString();
            if (currentState == "Hurt" || currentState == "Dead") return;

            CanDealDamage();
        }
    }

    void CanDealDamage()
    {
        string bossState = Boss.Instance.executer.GetCurrentState().Name;
        if (bossState == "Attack" && bossState != "Pounce")
        {
            Boss.Instance.health.TakeDamage();
            Player.Instance.push.PerformPushBoss();
            DataPointManager.Instance.GainPoint();
            Player.Instance.dealDamage.CreateHitEffect();
        }
    }
}
