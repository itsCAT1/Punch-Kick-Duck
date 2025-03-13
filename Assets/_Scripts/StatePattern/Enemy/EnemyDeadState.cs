using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using FSMC.Runtime;
using System;
using static UnityEngine.EventSystems.EventTrigger;

[Serializable]
public class EnemyDeadState : FSMC_Behaviour
{
    Enemy enemy;

    private float timeStart;
    public bool removeAttackTime => Time.time - timeStart >= 0.1f;

    public override void StateInit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {

    }
    public override void OnStateEnter(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        enemy = executer.GetComponent<Enemy>();
        enemy.animator.Play("Die");

        enemy.attack.canDealDamage = false;
        enemy.controller.canAttack = false;
        enemy.rigid.isKinematic = false;
        enemy.GetComponent<EnemyBeaten>().EnemyThrownOut();

        if (ConditionManger.Instance.currentState == GameState.InGame) enemy.coin.RandomDropCoin();
    }

    public override void OnStateUpdate(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        if(removeAttackTime) AttackingEnemyManager.Instance.ClearAttackingEnemy(enemy.gameObject);
    }

    public override void OnStateExit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        enemy.rigid.velocity = Vector3.zero;
    }
}