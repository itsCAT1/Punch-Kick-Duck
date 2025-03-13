using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using FSMC.Runtime;
using System;
using static UnityEngine.EventSystems.EventTrigger;

[Serializable]
public class MiniBossWalkState : FSMC_Behaviour
{
    bool playerInRange => Vector3.Distance(MiniBoss.Instance.transform.position, Player.Instance.transform.position) <= 10;


    public override void StateInit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {

    }
    public override void OnStateEnter(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        MiniBoss.Instance.animator.Play("Walk");
        MiniBoss.Instance.animator.SetBool("Walking", true);
        MiniBoss.Instance.rigid.isKinematic = false;
    }

    public override void OnStateUpdate(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        MiniBoss.Instance.movement.PerformMoving();
    }

    public override void OnStateExit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {

    }
}