using RMC.Core.UEvents;
using RMC.Core.UEvents.UEventDispatcher;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GoInAreaBossTrigger : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<GoLevelBoss>(OnLevelBoss);
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    void OnLevelBoss(IUEventData uEventData)
    {
        
    }

    
}
