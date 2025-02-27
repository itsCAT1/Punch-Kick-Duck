using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DG.Tweening;

public class MenuGameHandler : MonoBehaviour
{
    

    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    public void StartGame()
    {
        StartCoroutine(OnStartGame());
    }

    IEnumerator OnStartGame()
    {
        yield return new WaitForSeconds(0.4f);
        UEventData uEventData = new UEventData();
        UEventDispatcherSingleton.Instance.Invoke<StartGame>(uEventData);

        InGameManager.Instance.ShowUI();
    }
}
