using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using FSMC.Runtime;
using System;

[Serializable]
public class WalkState : FSMC_Behaviour
{
    PlayerController controller;

    public override void StateInit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        controller = Player.Instance.controller;
    }
    public override void OnStateEnter(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        controller.moveSpeed = 4;
        controller.SetDirection();
        Player.Instance.animator.Play("Walk");
    }

    public override void OnStateUpdate(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        Player.Instance.controller.UpdateAction();

        Player.Instance.movement.PerformMoving();
    }

    public override void OnStateExit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
    
    }
}