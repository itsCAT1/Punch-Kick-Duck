using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using FSMC.Runtime;
using System;

[Serializable]
public class BeeFlyState : FSMC_Behaviour
{
    BeeController controller;
    BeeMovement movement;
    private float timeStart = 0;
    public bool timeChangeState => Time.time - timeStart >= 4;

    public override void StateInit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {

    }
    public override void OnStateEnter(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        controller = executer.GetComponent<BeeController>();
        movement = executer.GetComponent<BeeController>().movement;

        movement.currentIndex = 0;
        movement.UpdatePosition();
        controller.PerformRotate();

        timeStart = Time.time;
    }

    public override void OnStateUpdate(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        movement.PerformMoving();
        if(timeChangeState)
        {
            executer.SetCurrentState("Attack");
        }
    }

    public override void OnStateExit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {

    }
}