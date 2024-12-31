using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using FSMC.Runtime;
using System;

[Serializable]
public class IdleStateTest : FSMC_Behaviour
{
    private float lastIdleTime;

    public bool timeChangeState => Time.time - lastIdleTime >= 3;
    public override void StateInit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        Debug.Log("Init Idle State");
        PlayerTest.Instance.controller.moveSpeed = 2;
    }
    public override void OnStateEnter(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        //PlayerTest.Instance.controller.animator.Play("Idle");
    }

    public override void OnStateUpdate(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        //if (timeChangeState) executer.SetBool("Walk", true);
        Debug.Log("Update Idle State");
    }

    public override void OnStateExit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
    
    }
}