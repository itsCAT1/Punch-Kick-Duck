using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using FSMC.Runtime;
using System;
using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;

[Serializable]
public class GetUpState : FSMC_Behaviour
{
    int currentHeart;
    private float timeStart = 0;
    public bool timeChangeState => Time.time - timeStart >= 0.5f;
    public override void StateInit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {

    }
    public override void OnStateEnter(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        currentHeart = Player.Instance.health.currentHeart;

        
        Player.Instance.attack.canAttack = true;
        Player.Instance.animator.Play("GetUp");
        timeStart = Time.time;
    }

    public override void OnStateUpdate(FSMC_Controller stateMachine, FSMC_Executer executer)
    {

        if (timeChangeState)
        {
            UEventData uEventData = new UEventData();
            UEventDispatcherSingleton.Instance.Invoke<InGame>(uEventData);
            UEventDispatcherSingleton.Instance.Invoke<PlayerRevive>(uEventData);

            SetPlayerAction();
        }

    }

    void SetPlayerAction()
    {
        Player.Instance.attack.canAttack = true;
        Player.Instance.health.currentHealth = 1;
        Player.Instance.health.currentHeart = currentHeart;
        Player.Instance.executer.SetCurrentState("Idle");
    }

    public override void OnStateExit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {

    }
}