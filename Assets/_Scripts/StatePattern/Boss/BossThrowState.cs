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

    public bool canThrow => Boss.Instance.controller.throwCount > 0;

    public bool playerInRange => Vector3.Distance(Boss.Instance.transform.position, Player.Instance.transform.position) <= 8;

    public override void StateInit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {

    }
    public override void OnStateEnter(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        Boss.Instance.pounce.RotateTowardPlayer();

        PerformThrow();
    }

    public override void OnStateUpdate(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        if (!canThrow || playerInRange)
        {
            Boss.Instance.controller.isAttacking = true;
            Boss.Instance.controller.isPounching = false;
            Boss.Instance.controller.isThrowing = false;
            Boss.Instance.controller.attackCount = 3;

            if (timeChangeState) ChangeState();

            return;
        }

        if (canThrow)
        {
            if (throwCoolDown) PerformThrow();
        }

        

    }

    void PerformThrow()
    {
        Boss.Instance.animator.Play("Throw");
        Boss.Instance.throwing.SetFruit();
        Boss.Instance.controller.throwCount--;
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