using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DG.Tweening;
using UnityEngine.UI;

public class MenuGameHandler : MonoBehaviour
{
    public Button buttonStart;

    private void OnEnable()
    {
        buttonStart.interactable = true;
    }

    public void StartGame()
    {
        buttonStart.interactable = false;
        StartCoroutine(OnStartGame());
    }

    IEnumerator OnStartGame()
    {
        yield return new WaitForSeconds(0.4f);
        UEventData uEventData = new UEventData();
        UEventDispatcherSingleton.Instance.Invoke<StartGame>(uEventData);
    }

    public void OpenOptions()
    {
        ConditionManger.Instance.SetState(GameState.Options);
    }
}
