using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using FSMC.Runtime;
using System;

[Serializable]
public class PunchState : FSMC_Behaviour
{
    private float timeStart = 0;
    private bool resetState => Time.time - timeStart >= 0.5f;

    public bool timeChangeState => Time.time - timeStart >= 0.7f;

    public override void StateInit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        
    }
    public override void OnStateEnter(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        Player.Instance.rigid.velocity = Vector3.zero;
        OnPunching();
    }

    void OnPunching()
    {
        if (Player.Instance.attack.punchLeft)
        {
            Player.Instance.animator.Play("PunchLeft");
        }
        else
        {
            Player.Instance.animator.Play("PunchRight");
        }

        Player.Instance.attack.punchLeft = !Player.Instance.attack.punchLeft;
        timeStart = Time.time;
    }

    public override void OnStateUpdate(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        if (resetState) Player.Instance.attack.punchLeft = true;
        if (timeChangeState && (ConditionManger.Instance.currentState == GameState.InGame || ConditionManger.Instance.currentState == GameState.Tutorial))
        {
            Player.Instance.controller.UpdateAction();
        }
    }

    public override void OnStateExit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
    
    }
}