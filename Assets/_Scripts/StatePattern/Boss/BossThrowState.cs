using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using FSMC.Runtime;
using System;

[Serializable]
public class BossThrowState : FSMC_Behaviour
{
    private float timeStart = 0;
    
    public bool throwCoolDown => Time.time - timeStart >= 3;
    public bool timeChangeState => Time.time - timeStart >= 1;

    public bool CanThrow()
    {
        var distance = Vector3.Distance(Boss.Instance.transform.position, Player.Instance.transform.position);

        if (Boss.Instance.controller.throwCount <= 0 || distance <= 5)
        {
            return false;
        }
            
        return true;
    }

    public override void StateInit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {

    }
    public override void OnStateEnter(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        PerformThrow();
    }

    public override void OnStateUpdate(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        if (!CanThrow())
        {
            Boss.Instance.controller.isAttacking = true;
            Boss.Instance.controller.isPounching = false;
            Boss.Instance.controller.isThrowing = false;
            Boss.Instance.controller.attackCount = 5;

            if (timeChangeState) ChangeState();

            return;
        }

        else
        {
            if (throwCoolDown) PerformThrow();
        }
    }

    void PerformThrow()
    {
        Boss.Instance.animator.Play("Throw");
        Boss.Instance.throwing.SetFruit();
        timeStart = Time.time;
    }

    void ChangeState()
    {

        Boss.Instance.controller.SetAction();

        Boss.Instance.controller.isUpdate = true;
    }

    public override void OnStateExit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {

    }
}