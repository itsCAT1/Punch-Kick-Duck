using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using FSMC.Runtime;
using System;
using static UnityEngine.EventSystems.EventTrigger;
using static Cinemachine.AxisState;
using Unity.VisualScripting;

[Serializable]
public class EnemyWinState : FSMC_Behaviour
{
    Enemy enemy;

    private float timeStart;
    public bool timeChangeState => Time.time - timeStart >= 0.5f;

    bool playerInRange => Vector3.Distance(enemy.transform.position, Player.Instance.transform.position) <= 15;

    public override void StateInit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        
    }
    public override void OnStateEnter(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        enemy = executer.GetComponent<Enemy>();

        enemy.rigid.isKinematic = false;
        enemy.controller.canAttack = false;

        enemy.GetComponent<EnemyGoingBack>().PerformGoingBack();
        timeStart = Time.time;
    }


    public override void OnStateUpdate(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        if (timeChangeState)
        {
            enemy.animator.Play("Win");
        }


    }

    public override void OnStateExit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        
    }
}