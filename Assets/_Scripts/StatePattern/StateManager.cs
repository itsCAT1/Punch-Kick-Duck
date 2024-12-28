using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class StateManager : MonoBehaviour
{
    public IState currentState;

    public void ChangeState(IState state)
    {
        /*if(currentState != null && currentState.GetType() == state.GetType())
        {
            return;
        }*/

        currentState?.Exit();

        currentState = state;

        currentState?.Enter();
    }

    private void Update()
    {
        currentState?.Execute();
    }
}
