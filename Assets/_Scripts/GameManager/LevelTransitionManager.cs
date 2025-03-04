using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LevelTransitionManager : Singleton<LevelTransitionManager>
{

    private void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<LevelTransition>(ChangeLevel);
    }

    void ChangeLevel(IUEventData uEventData)
    {
        if(DataManager.Instance.data.currentMap < 10)
        {
            DataManager.Instance.data.currentMap++;
        }
    }
}
