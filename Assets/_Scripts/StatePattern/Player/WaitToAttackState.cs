using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using FSMC.Runtime;
using System;

[Serializable]
public class WaitToAttackState : FSMC_Behaviour
{
    private float timeStart = 0;
    public bool timeChangeState => Time.time - timeStart >= 2;

    public override void StateInit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {

    }
    public override void OnStateEnter(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        Player.Instance.rigid.velocity = Vector3.zero;
        Player.Instance.animator.Play("Idle");

        Player.Instance.attack.canAttack = false;
        Player.Instance.followBoss.isWaiting = true;
        Player.Instance.followBoss.canWait = true;
        DataInGame.Instance.inRoom = true;
        Boss.Instance.reaction.soundRoar.PlayDelayed(1);

        timeStart = Time.time;
    }

    public override void OnStateUpdate(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        if (timeChangeState)
        {
            Player.Instance.attack.canAttack = true;
            Player.Instance.followBoss.canWait = false;
            Player.Instance.executer.SetCurrentState("Walk");
        }
    }

    public override void OnStateExit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {

    }
}