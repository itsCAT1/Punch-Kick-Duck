using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using FSMC.Runtime;
using System;

[Serializable]
public class BossWalkState : FSMC_Behaviour
{

    public override void StateInit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {

    }
    public override void OnStateEnter(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        Boss.Instance.pounce.PerformRotate(Player.Instance.transform);
        Boss.Instance.animator.Play("Walk");
    }

    public override void OnStateUpdate(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        if (ReachedTarget())
        {
            Boss.Instance.executer.SetCurrentState("Throw");
            return;
        }

        
        Boss.Instance.pounce.PerformMoving();
    }

    bool ReachedTarget()
    {
        if (Vector3.Distance(Boss.Instance.transform.position, Boss.Instance.pounce.targetPos) < 0.01f)
        {
            return true;
        }
        else
            return false;
    }

    public override void OnStateExit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {

    }
}