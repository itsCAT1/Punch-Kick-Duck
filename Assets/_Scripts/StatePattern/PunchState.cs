using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using FSMC.Runtime;
using System;

[Serializable]
public class PunchState : FSMC_Behaviour
{
    private float timeStart = 0;
    private bool resetState => Time.time - timeStart >= 1f;

    float interval;
    public bool timeChangeState => Time.time - timeStart >= interval;

    public override void StateInit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        
    }
    public override void OnStateEnter(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        Player.Instance.controller.rigid.velocity = Vector3.zero;
        OnPunching();

        if (!ConditionManger.Instance.startGame)
        {
            interval = 0.5f;
        }
        else
        {
            interval = 1.5f;
        }
    }

    void OnPunching()
    {
        if (Player.Instance.attack.punchLeft)
        {
            Player.Instance.controller.animator.Play("PunchLeft");
        }
        else
        {
            Player.Instance.controller.animator.Play("PunchRight");
        }

        Player.Instance.attack.punchLeft = !Player.Instance.attack.punchLeft;
        timeStart = Time.time;
    }

    public override void OnStateUpdate(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        if (resetState) Player.Instance.attack.punchLeft = true;
        if (timeChangeState && ConditionManger.Instance.startGame) Player.Instance.controller.executer.SetCurrentState("Walk");
    }

    public override void OnStateExit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
    
    }
}