using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using FSMC.Runtime;
using System;
using static UnityEngine.EventSystems.EventTrigger;

[Serializable]
public class EnemyTutorialState : FSMC_Behaviour
{
    Enemy enemy;

    private float timeStart = 0;
    public bool timeChangeState => Time.time - timeStart >= 3;


    public override void StateInit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {

    }
    public override void OnStateEnter(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        enemy = executer.GetComponent<Enemy>();

        enemy.rigid.velocity = Vector3.zero;
        enemy.controller.Standing();

        enemy.rigid.isKinematic = true;

        enemy.tutorial.canWait = true;
        enemy.tutorial.isWaiting = true;

        timeStart = Time.time;
    }

    public override void OnStateUpdate(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        if(timeChangeState)
        {
            enemy.tutorial.canWait = false;
            enemy.executer.SetCurrentState("Walk");
        }
    }

    public override void OnStateExit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {

    }
}