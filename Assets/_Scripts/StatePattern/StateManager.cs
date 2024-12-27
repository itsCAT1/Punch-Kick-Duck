using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class StateManager : MonoBehaviour
{
    public IState currentState;

    public void ChangeState(IState state)
    {
        if(currentState != null && currentState.GetType() == state.GetType())
        {
            return;
        }

        if (currentState != null)
        {
            currentState.Exit();
        }

        if (currentState != null)
        {
            currentState = state;
        }

        if (currentState != null)
        {
            currentState.Enter();
        }
    }

    private void Update()
    {
        if (currentState != null)
        {
            currentState.Execute();
        }
    }
}
