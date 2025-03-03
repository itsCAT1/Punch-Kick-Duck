using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using FSMC.Runtime;
using System;

[Serializable]
public class EnemyBlockState : FSMC_Behaviour
{
    Enemy enemy;

    private float timeStart;
    private float interval;
    public bool timeChangeState => Time.time - timeStart >= interval;
    public override void StateInit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {

    }
    public override void OnStateEnter(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        enemy = executer.GetComponent<Enemy>();

        enemy.controller.canAttack = false;
        enemy.rigid.isKinematic = false;

        enemy.animator.Play("Block");
        enemy.GetComponent<EnemyOnBlocking>().EnemyIsRepelled();

        if (ConditionManger.Instance.currentState == GameState.InGame) interval = 1.5f;
        if (ConditionManger.Instance.currentState == GameState.Tutorial) interval = 3f;

        timeStart = Time.time;
    }

    public override void OnStateUpdate(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        if (timeChangeState)
        {
            enemy.controller.canAttack = true;
            enemy.executer.SetCurrentState("Walk");
        }
    }

    public override void OnStateExit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        
    }
}