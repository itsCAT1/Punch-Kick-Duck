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
    public bool timeChangeState => Time.time - timeStart >= 1;

    public bool canThrow => Boss.Instance.controller.throwCount > 0;

    public override void StateInit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {

    }
    public override void OnStateEnter(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        Boss.Instance.pounce.RotateTowardPlayer();

        Boss.Instance.controller.throwCount = 3;
        PerformThrow();
    }

    public override void OnStateUpdate(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        if (throwCoolDown && canThrow)
        {
            PerformThrow();
        }
        if (timeChangeState && !canThrow)
        {
            Boss.Instance.controller.isThrowing = false;
        }
            
    }

    void PerformThrow()
    {
        Boss.Instance.animator.Play("Throw");
        Boss.Instance.controller.throwCount--;
        timeStart = Time.time;
    }

    public override void OnStateExit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {

    }
}