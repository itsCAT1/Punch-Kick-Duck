using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using FSMC.Runtime;
using System;

[Serializable]
public class EnemyThrowState : FSMC_Behaviour
{
    Enemy enemy;

    private float timeStart;
    public bool timeChangeState => Time.time - timeStart >= 2;
    public override void StateInit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {

    }
    public override void OnStateEnter(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        enemy = executer.GetComponent<Enemy>();

        enemy.controller.canAttack = false;
        enemy.rigid.isKinematic = true;

        enemy.controller.Standing();
        enemy.thowBottle.PerformThrowBottle();
        
        timeStart = Time.time;
    }

    public override void OnStateUpdate(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        if (!AttackingEnemyManager.Instance.CanAttack(enemy.gameObject))
        {
            return;
        }

        AttackingEnemyManager.Instance.SetAttackingEnemy(enemy.gameObject);

        if (timeChangeState)
        {
            enemy.controller.canAttack = true;
        }
    }

    public override void OnStateExit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {

    }
}