using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SelfDestroy : MonoBehaviour
{
    public float timeDuration;
    private void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<StartGame>(Destroy);
    }

    void Destroy(IUEventData eventData)
    {
        Destroy(gameObject, timeDuration);
    }
}
