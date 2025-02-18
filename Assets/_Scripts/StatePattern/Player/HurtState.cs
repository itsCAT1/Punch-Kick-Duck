using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using FSMC.Runtime;
using System;
using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;

[Serializable]
public class HurtState : FSMC_Behaviour
{
    private float timeStart = 0;
    public bool timeChangeState => Time.time - timeStart >= 1.5f;
    public override void StateInit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        
    }
    public override void OnStateEnter(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        Player.Instance.animator.Play("Hurt");

        UEventData uEventData = new UEventData();
        UEventDispatcherSingleton.Instance.Invoke<PlayerHurt>(uEventData);

        timeStart = Time.time;
    }

    public override void OnStateUpdate(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        
        if (timeChangeState)
        {
            Debug.Log("walk");
            Player.Instance.executer.SetCurrentState("Walk");
        }
            
    }

    public override void OnStateExit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
         
    }
}