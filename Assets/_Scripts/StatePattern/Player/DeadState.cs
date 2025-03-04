using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using FSMC.Runtime;
using System;
using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;

[Serializable]
public class DeadState : FSMC_Behaviour
{
    private float timeStart = 0;
    public bool timeChangeState => Time.time - timeStart >= 0.5f;
    bool isOver;

    public override void StateInit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {

    }
    public override void OnStateEnter(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        Player.Instance.attack.canAttack = false;
        Player.Instance.animator.Play("Die");

        UEventData uEventData = new UEventData();
        UEventDispatcherSingleton.Instance.Invoke<PlayerDeath>(uEventData);

        isOver = false;
        timeStart = Time.time;
    }

    public override void OnStateUpdate(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        if (timeChangeState && !isOver)
        {
            isOver = true;
            UEventData uEventData = new UEventData();
            UEventDispatcherSingleton.Instance.Invoke<GameOver>(uEventData);
        }
    }

    public override void OnStateExit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {

    }
}