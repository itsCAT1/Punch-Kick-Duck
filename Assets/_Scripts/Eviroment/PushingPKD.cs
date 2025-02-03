using RMC.Core.UEvents;
using RMC.Core.UEvents.UEventDispatcher;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PushingPKD : PushingText
{

    private void OnTriggerEnter(Collider other)
    {
        if(other.gameObject.CompareTag("Punch") || other.gameObject.CompareTag("Kick") || other.gameObject.CompareTag("Duck") 
            && !ConditionManger.Instance.isStartGame)
        {
            UEventData uEventData = new UEventData();
            UEventDispatcherSingleton.Instance.Invoke<StartGame>(uEventData);
            PerformPushing();
        }
    }
}
