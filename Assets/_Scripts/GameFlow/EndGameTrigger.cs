using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EndGameTrigger : MonoBehaviour
{
    NextLevelHandler nextLevel;
    private void Start()
    {
        nextLevel = GetComponent<NextLevelHandler>();
        UEventDispatcherSingleton.Instance.AddEventListener<EndGame>(ChangeStatePlayer);
    }

    public void ChangeStatePlayer(IUEventData uEventData)
    {
        Player.Instance.controller.executer.SetCurrentState("EndGame");
    }


    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.CompareTag("Player"))
        {
            nextLevel.PlayerMoving();
            UEventData uEventData = new UEventData();
            UEventDispatcherSingleton.Instance.Invoke<EndGame>(uEventData);
        }
    }
}
