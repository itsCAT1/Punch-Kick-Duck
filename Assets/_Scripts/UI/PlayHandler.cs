using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayHandler : MonoBehaviour
{
    void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<MenuGame>(SetPlayerPosition);
    }

    public void BackMenu()
    {
        StartCoroutine(StartQuit());
    }

    IEnumerator StartQuit()
    {
        yield return new WaitForSeconds(0.2f);
        LoadSceneHandler.Instance.LoadScene();

        UEventData uEventData = new UEventData();
        UEventDispatcherSingleton.Instance.Invoke<MenuGame>(uEventData);
    }

    void SetPlayerPosition(IUEventData uEventData)
    {
        Player.Instance.controller.SetPosition();
        Player.Instance.controller.SetDirection();
    }
}
