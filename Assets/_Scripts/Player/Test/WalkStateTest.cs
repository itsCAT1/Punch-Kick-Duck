using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using FSMC.Runtime;
using System;

[Serializable]
public class WalkStateTest : FSMC_Behaviour
{
    public override void StateInit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        Debug.Log("Init Walk State");
        Player.Instance.controller.moveSpeed = 2;
        Player.Instance.controller.facingDirection = 1;
    }
    public override void OnStateEnter(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        //Player.Instance.controller.animator.Play("Walk");
    }

    public override void OnStateUpdate(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        Debug.Log("Update Walk State");
    }

    public override void OnStateExit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
    
    }
}