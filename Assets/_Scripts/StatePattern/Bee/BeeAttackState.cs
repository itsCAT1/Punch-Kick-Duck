using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using FSMC.Runtime;
using System;

[Serializable]
public class BeeAttackState : FSMC_Behaviour
{
    Bee bee;

    public override void StateInit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {

    }
    public override void OnStateEnter(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        bee = executer.GetComponent<Bee>();

        bee.attack.currentIndex = 0;
        bee.attack.UpdatePosition();

        bee.controller.PerformRotate();
    }

    public override void OnStateUpdate(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        bee.attack.PerformMoving();
    }

    public override void OnStateExit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {

    }
}