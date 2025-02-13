using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using FSMC.Runtime;
using System;

[Serializable]
public class BeeAttackState : FSMC_Behaviour
{
    BeeController controller;
    BeeAttack attack;

    public override void StateInit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {

    }
    public override void OnStateEnter(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        controller = executer.GetComponent<BeeController>();
        attack = executer.GetComponent<BeeController>().attack;

        attack.currentIndex = 0;
        attack.UpdatePosition();
        controller.PerformRotate();
    }

    public override void OnStateUpdate(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        attack.PerformMoving();
    }

    public override void OnStateExit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {

    }
}