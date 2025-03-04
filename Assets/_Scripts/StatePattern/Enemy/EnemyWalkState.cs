using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using FSMC.Runtime;
using System;
using static UnityEngine.EventSystems.EventTrigger;

[Serializable]
public class EnemyWalkState : FSMC_Behaviour
{
    Enemy enemy;

    public override void StateInit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {

    }
    public override void OnStateEnter(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        enemy = executer.GetComponent<Enemy>();

        enemy.rigid.isKinematic = false;
        enemy.animator.Play("Walk");
        enemy.controller.Moving();

    }

    public override void OnStateUpdate(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        enemy.movement.PerformMove();
    }

    public override void OnStateExit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        
    }
}