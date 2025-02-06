using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using FSMC.Runtime;
using System;
using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;

[Serializable]
public class EndGameState : FSMC_Behaviour
{
    private float timeStart;

    public bool timeChangeState => Time.time - timeStart >= 14;

    public override void StateInit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        
    }

    public override void OnStateEnter(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        timeStart = Time.time;

        Player.Instance.controller.rigid.velocity = Vector3.zero;
        Player.Instance.controller.animator.Play("Walk");
    }

    public override void OnStateUpdate(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        if (timeChangeState)
        {
            Player.Instance.controller.executer.SetCurrentState("Walk");
            UEventData uEventData = new UEventData();
            UEventDispatcherSingleton.Instance.Invoke<LevelTransition>(uEventData);
        }
    }

    public override void OnStateExit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {

    }
}