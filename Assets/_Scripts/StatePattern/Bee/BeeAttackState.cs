using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using FSMC.Runtime;
using System;

[Serializable]
public class BeeAttackState : FSMC_Behaviour
{
    Bee bee;

    bool isBuzzing;

    bool playerInRange => Vector3.Distance(bee.transform.position, Player.Instance.transform.position) <= 7;

    public override void StateInit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {

    }
    public override void OnStateEnter(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        bee = executer.GetComponent<Bee>();

        bee.attack.currentIndex = 0;
        bee.attack.UpdatePosition();

        bee.controller.PerformRotate();
        isBuzzing = false;
    }

    public override void OnStateUpdate(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        bee.attack.PerformMoving();

        if(playerInRange && !isBuzzing)
        {
            isBuzzing = true;
            bee.controller.attackSound.Play();
        }
    }

    public override void OnStateExit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {

    }
}