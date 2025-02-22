using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RestartHandler : MonoBehaviour
{

    void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<RestartGame>(SetPlayerPosition);
    }

    public void Restart()
    {
        StartCoroutine(StartRestart());
    }

    IEnumerator StartRestart()
    {
        yield return new WaitForSeconds(0.3f);
        UEventData uEventData = new UEventData();
        UEventDispatcherSingleton.Instance.Invoke<RestartGame>(uEventData);
        UEventDispatcherSingleton.Instance.Invoke<InGame>(uEventData);
    }

    void SetPlayerPosition(IUEventData uEventData)
    {
        Player.Instance.controller.SetPosition();
        Player.Instance.controller.SetDirection();
    }
}
