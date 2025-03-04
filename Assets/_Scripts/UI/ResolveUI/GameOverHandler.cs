using RMC.Core.UEvents;
using RMC.Core.UEvents.UEventDispatcher;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameOverHandler : MonoBehaviour
{

    void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<MenuGame>(ClosePanel);
        UEventDispatcherSingleton.Instance.AddEventListener<RestartGame>(ClosePanel);
    }

    void ClosePanel(IUEventData uEventData)
    {
        this.gameObject.SetActive(false);
    }
}
