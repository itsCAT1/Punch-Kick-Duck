using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TutorialManager : Singleton<TutorialManager>
{
    public bool hasPunched;
    public bool hasKicked;
    public bool hasDucked;

    void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<StartGame>(UpdateTutorial);
    }

    void Update()
    {
        
    }

    void UpdateTutorial(IUEventData uEventData)
    {
        if(DataManager.Instance.data.showTutorial) hasPunched = true;
    }
}
