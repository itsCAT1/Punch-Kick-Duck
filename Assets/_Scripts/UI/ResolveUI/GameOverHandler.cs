using RMC.Core.UEvents;
using RMC.Core.UEvents.UEventDispatcher;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameOverHandler : MonoBehaviour
{
    public GameObject gameOverUI;

    void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<MenuGame>(ClosePanel);
        UEventDispatcherSingleton.Instance.AddEventListener<RestartGame>(ClosePanel);
    }

    void ClosePanel(IUEventData uEventData)
    {
        this.gameObject.SetActive(false);
    }

    public void SelectCharactor()
    {
        UEventData uEventData = new UEventData();
        UEventDispatcherSingleton.Instance.Invoke<CharactorSelection>(uEventData);

        gameOverUI.SetActive(false);
    }
}
