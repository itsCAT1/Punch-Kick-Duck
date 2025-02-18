using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using FSMC.Runtime;
using System;

[Serializable]
public class BossAttackState : FSMC_Behaviour
{
    private float timeStart = 0;
    public bool attackCooldown => Time.time - timeStart >= 2;
    public bool timeChangeState => Time.time - timeStart >= 2;

    public bool canAttack => Boss.Instance.controller.attackCount > 0;

    public override void StateInit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {

    }
    public override void OnStateEnter(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        PerformAttack();
    }

    public override void OnStateUpdate(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        if (canAttack)
        {
            if(attackCooldown) PerformAttack();
        }

        else
        {
            Boss.Instance.controller.isUpdate = false;
            Boss.Instance.controller.isAttacking = false;
            Boss.Instance.controller.isPounching = true;
            Boss.Instance.controller.isThrowing = false;
            Boss.Instance.controller.throwCount = 3;

            if (timeChangeState) ChangeState();
        }
    }

    void PerformAttack()
    {
        Boss.Instance.attackType.type = (AttackType)UnityEngine.Random.Range(0, 3);
        Boss.Instance.animator.Play(Boss.Instance.attackType.type.ToString());
        Boss.Instance.controller.attackCount--;
        timeStart = Time.time;
    }

    void ChangeState()
    {
        Boss.Instance.executer.SetCurrentState("Pounce");
    }

    public override void OnStateExit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {

    }
}