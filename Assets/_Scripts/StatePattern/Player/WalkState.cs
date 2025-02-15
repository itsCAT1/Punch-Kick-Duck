using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using FSMC.Runtime;
using System;

[Serializable]
public class WalkState : FSMC_Behaviour
{
    PlayerController controller;
    bool bossInRange => Vector3.Distance(Player.Instance.transform.position, Boss.Instance.transform.position) <= 3f;

    public override void StateInit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        controller = Player.Instance.controller;
    }
    public override void OnStateEnter(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        controller.moveSpeed = 4;
        controller.SetDirection();
        controller.animator.Play("Walk");
    }

    public override void OnStateUpdate(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        if(DataManager.Instance.data.currentMap == 10 && bossInRange)
        {
            controller.rigid.velocity = Vector3.zero;
            return;
        }

        Player.Instance.movement.PerformMoving();
    }

    public override void OnStateExit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
    
    }
}