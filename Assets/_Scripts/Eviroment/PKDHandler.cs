using RMC.Core.UEvents;
using RMC.Core.UEvents.UEventDispatcher;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PKDHandler : PushingText
{

    private void Update()
    {
        SelfDestroy();
    }

    void SelfDestroy()
    {
        if(Vector3.Distance(this.transform.position, Player.Instance.transform.position) >= 20)
        {
            Destroy(this.gameObject);
        }
    }

    private void OnTriggerEnter(Collider other)
    {
        if(other.gameObject.CompareTag("Punch") || other.gameObject.CompareTag("Kick") || other.gameObject.CompareTag("Duck") 
            && !ConditionManger.Instance.startGame)
        {
            UEventData uEventData = new UEventData();
            UEventDispatcherSingleton.Instance.Invoke<StartGame>(uEventData);
            PerformPushing();
        }
    }
}
