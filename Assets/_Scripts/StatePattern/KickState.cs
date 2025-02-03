using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using FSMC.Runtime;
using System;

[Serializable]
public class KickState : FSMC_Behaviour
{
    private float timeStart = 0;
    public bool timeChangeState => Time.time - timeStart >= 2f;

    public override void StateInit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        
    }
    public override void OnStateEnter(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        Player.Instance.controller.rigid.velocity = Vector3.zero;
        Player.Instance.controller.animator.Play("Kick");
        timeStart = Time.time;
    }

    public override void OnStateUpdate(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        if (timeChangeState && ConditionManger.Instance.isStartGame) Player.Instance.controller.executer.SetCurrentState("Walk");
    }

    public override void OnStateExit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {

    }
}