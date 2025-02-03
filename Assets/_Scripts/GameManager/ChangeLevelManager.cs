using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ChangeLevelManager : Singleton<ChangeLevelManager>
{

    private void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<ChangeLevel>(ChangeLevel);
    }

    void ChangeLevel(IUEventData uEventData)
    {
        if(DataManager.Instance.data.currentMap < 9)
        {
            DataManager.Instance.data.currentMap++;
        }
    }
}
