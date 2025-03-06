using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using FSMC.Runtime;
using System;
using static UnityEngine.EventSystems.EventTrigger;

[Serializable]
public class MiniBossWinState : FSMC_Behaviour
{
    public override void StateInit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {

    }
    public override void OnStateEnter(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        MiniBoss.Instance.animator.Play("Win");
        MiniBoss.Instance.rigid.isKinematic = true;
    }

    public override void OnStateUpdate(FSMC_Controller stateMachine, FSMC_Executer executer)
    {

    }

    public override void OnStateExit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        MiniBoss.Instance.rigid.velocity = Vector3.zero;
    }
}