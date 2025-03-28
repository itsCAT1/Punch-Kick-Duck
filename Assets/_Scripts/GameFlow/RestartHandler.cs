using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RestartHandler : MonoBehaviour
{
    public void Restart()
    {
        StartCoroutine(StartRestart());
    }

    IEnumerator StartRestart()
    {
        DataManager.Instance.data.showTutorial = false;

        yield return new WaitForSeconds(0.2f);
        LoadSceneHandler.Instance.LoadScene();

        UEventData uEventData = new UEventData();
        UEventDispatcherSingleton.Instance.Invoke<RestartGame>(uEventData);
        UEventDispatcherSingleton.Instance.Invoke<InGame>(uEventData);
    }
}
