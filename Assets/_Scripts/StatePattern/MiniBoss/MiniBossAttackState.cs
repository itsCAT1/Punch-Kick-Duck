using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using FSMC.Runtime;
using System;
using static UnityEngine.EventSystems.EventTrigger;

[Serializable]
public class MiniBossAttackState : FSMC_Behaviour
{
    private float timeStart;
    bool attackCooldown => Time.time - timeStart >= 0.5f;
    public override void StateInit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {

    }
    public override void OnStateEnter(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        MiniBoss.Instance.animator.SetBool("Walking", false);
        MiniBoss.Instance.rigid.isKinematic = true;

        timeStart = Time.time;
    }

    public override void OnStateUpdate(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        if (attackCooldown)
        {
            MiniBoss.Instance.attack.PerformAttack();
        }

    }

    public override void OnStateExit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        
    }
}