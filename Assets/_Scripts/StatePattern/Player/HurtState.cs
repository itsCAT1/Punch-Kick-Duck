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
    private float interval;
    public bool timeChangeState => Time.time - timeStart >= interval;
    public override void StateInit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        
    }
    public override void OnStateEnter(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        Player.Instance.attack.canAttack = false;
        Player.Instance.animator.Play("Hurt");

        UEventData uEventData = new UEventData();
        UEventDispatcherSingleton.Instance.Invoke<PlayerHurt>(uEventData);

        if (ConditionManger.Instance.currentState == GameState.InGame) interval = 1.5f;
        if (ConditionManger.Instance.currentState == GameState.Tutorial) interval = 3f;

        timeStart = Time.time;
    }

    public override void OnStateUpdate(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        
        if (timeChangeState)
        {
            Player.Instance.attack.canAttack = true;
            Player.Instance.executer.SetCurrentState("Walk");
        }
            
    }

    public override void OnStateExit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
         
    }
}