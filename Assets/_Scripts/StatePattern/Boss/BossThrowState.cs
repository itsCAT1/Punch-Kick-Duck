using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using FSMC.Runtime;
using System;

[Serializable]
public class BossThrowState : FSMC_Behaviour
{
    private float timeStart = 0;
    public bool throwCoolDown => Time.time - timeStart >= 2;

    public override void StateInit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {

    }
    public override void OnStateEnter(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        Boss.Instance.pounce.RotateTowardPlayer();
        Boss.Instance.animator.Play("Throw");

        timeStart = Time.time;
    }

    public override void OnStateUpdate(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        if (throwCoolDown)
        {
            Boss.Instance.animator.Play("Throw");
            timeStart = Time.time;
        }
    }

    public override void OnStateExit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {

    }
}