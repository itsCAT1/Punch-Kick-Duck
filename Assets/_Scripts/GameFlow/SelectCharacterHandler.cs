using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SelectCharacterHandler : MonoBehaviour
{
    public GameObject gameOverUI;

    public void SelectCharactor()
    {
        UEventData uEventData = new UEventData();
        UEventDispatcherSingleton.Instance.Invoke<CharactorSelection>(uEventData);

        gameOverUI.SetActive(false);
    }
}
