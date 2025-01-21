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
    private bool timeChangeState => Time.time - timeStart >= 2f;

    public override void StateInit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        
    }
    public override void OnStateEnter(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        Player.Instance.controller.moveSpeed = 0;
        OnPerformPunch();
    }

    void OnPerformPunch()
    {
        if (Player.Instance.performAttack.punchLeft)
        {
            Player.Instance.controller.animator.Play("PunchLeft");
        }
        else
        {
            Player.Instance.controller.animator.Play("PunchRight");
        }

        Player.Instance.performAttack.punchLeft = !Player.Instance.performAttack.punchLeft;
        timeStart = Time.time;
    }

    public override void OnStateUpdate(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        if (resetState) Player.Instance.performAttack.punchLeft = true;
        if (timeChangeState) Player.Instance.controller.executer.SetCurrentState("Walk");
    }

    public override void OnStateExit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
    
    }
}