using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using FSMC.Runtime;
using System;
using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;

[Serializable]
public class BossDeadState : FSMC_Behaviour
{
    private float timeStart = 0;
    public bool timeChangeState => Time.time - timeStart >= 1;

    public override void StateInit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {

    }
    public override void OnStateEnter(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        Boss.Instance.controller.isUpdate = false;
        Boss.Instance.animator.Play("Dead");

        CameraManager.Instance.FollowBoss();

        Player.Instance.executer.SetCurrentState("Win");

        foreach (var fruit in Boss.Instance.throwing.fruitAvatar)
        {
            fruit.SetActive(false);
        }
        
        UEventData uEventData = new UEventData();
        UEventDispatcherSingleton.Instance.Invoke<EndGameBoss>(uEventData);
    }

    public override void OnStateUpdate(FSMC_Controller stateMachine, FSMC_Executer executer)
    {


    }

    public override void OnStateExit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {

    }
}