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
    public override void StateInit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {

    }
    public override void OnStateEnter(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        Player.Instance.controller.animator.Play("Die");

        UEventData uEventData = new UEventData();
        UEventDispatcherSingleton.Instance.Invoke<PlayerDeath>(uEventData);
        UEventDispatcherSingleton.Instance.Invoke<GameOver>(uEventData);
    }

    public override void OnStateUpdate(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        
    }

    public override void OnStateExit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {

    }
}