using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using FSMC.Runtime;
using System;

[Serializable]
public class DuckStateTest : FSMC_Behaviour
{
    public override void StateInit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
        Debug.Log("Init Duck State");
    }
    public override void OnStateEnter(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
    
    }

    public override void OnStateUpdate(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
    
    }

    public override void OnStateExit(FSMC_Controller stateMachine, FSMC_Executer executer)
    {
    
    }
}