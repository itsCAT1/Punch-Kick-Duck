using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using FSMC.Runtime;
using System;

[Serializable]
public class KickState : FSMC_Behaviour
{
    private float timeStart = 0;
    float interval;
    public bool timeChangeState => Time.time - timeStart >= interval;

    public override void StateInit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        
    }
    public override void OnStateEnter(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        Player.Instance.rigid.velocity = Vector3.zero;
        Player.Instance.animator.Play("Kick");
        timeStart = Time.time;

        if (!ConditionManger.Instance.inGame)
        {
            interval = 1f;
        }
        else
        {
            interval = 1f;
        }
    }

    public override void OnStateUpdate(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        if (timeChangeState && ConditionManger.Instance.inGame) Player.Instance.controller.UpdateAction();
    }

    public override void OnStateExit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {

    }
}