using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using FSMC.Runtime;
using System;

[Serializable]
public class DuckState : FSMC_Behaviour
{
    private float timeStart;

    public bool timeChangeState => Time.time - timeStart >= 2;

    public override void StateInit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        
    }
    public override void OnStateEnter(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        Player.Instance.controller.rigid.velocity = Vector3.zero;
        Player.Instance.controller.animator.Play("Duck");
        timeStart = Time.time;
    }

    public override void OnStateUpdate(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        if (timeChangeState) Player.Instance.controller.executer.SetCurrentState("Walk");
    }

    public override void OnStateExit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {

    }
}