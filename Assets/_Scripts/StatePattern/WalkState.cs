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
        controller.moveSpeed = 5;
        controller.GetDirection();
        controller.animator.Play("Walk");
    }

    public override void OnStateUpdate(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        controller.rigid.velocity = new Vector3(controller.moveSpeed * controller.playerDirection, controller.rigid.velocity.y, controller.rigid.velocity.z);
    }

    public override void OnStateExit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
    
    }
}