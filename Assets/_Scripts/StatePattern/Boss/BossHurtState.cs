using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using FSMC.Runtime;
using System;

[Serializable]
public class BossHurtState : FSMC_Behaviour
{
    private float timeStart = 0;
    public bool timeChangeState => Time.time - timeStart >= 1f;

    public override void StateInit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {

    }
    public override void OnStateEnter(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        Boss.Instance.controller.isUpdate = false;
        Boss.Instance.animator.Play("Hurt");
        
        Boss.Instance.coin.RandomDropCoin();

        timeStart = Time.time;
    }

    public override void OnStateUpdate(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        if (timeChangeState)
        {
            Boss.Instance.controller.SetAction();

            Boss.Instance.controller.isUpdate = true;
        }
    }

    public override void OnStateExit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {

    }
}