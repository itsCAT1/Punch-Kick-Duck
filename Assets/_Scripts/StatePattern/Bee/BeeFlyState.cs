using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using FSMC.Runtime;
using System;

[Serializable]
public class BeeFlyState : FSMC_Behaviour
{
    Bee bee;

    private float timeStart = 0;
    public bool timeChangeState => Time.time - timeStart >= 4.2f;

    public override void StateInit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {

    }
    public override void OnStateEnter(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        bee = executer.GetComponent<Bee>();

        bee.movement.currentIndex = 0;
        bee.movement.UpdatePosition();
        bee.controller.PerformRotate();
        bee.controller.attackSound.Stop();

        timeStart = Time.time;
    }

    public override void OnStateUpdate(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        bee.movement.PerformMoving();

        if(timeChangeState)
        {
            executer.SetCurrentState("Attack");
        }
    }

    public override void OnStateExit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {

    }
}