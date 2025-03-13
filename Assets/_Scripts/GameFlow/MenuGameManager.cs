using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DG.Tweening;
using UnityEngine.UI;
using UnityEditor;

public class MenuGameManager : Singleton<MenuGameManager>
{
    public Button buttonStart;
    public bool isStarting;

    private void OnEnable()
    {
        buttonStart.interactable = true;
    }

    private void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<MenuGame>(OnMenu);
    }

    public void StartGame()
    {
        buttonStart.interactable = false;
        StartCoroutine(OnStartGame());
    }

    IEnumerator OnStartGame()
    {
        isStarting = true;

        yield return new WaitForSeconds(0.4f);
        UEventData uEventData = new UEventData();
        UEventDispatcherSingleton.Instance.Invoke<StartGame>(uEventData);
    }

    public void OpenOptions()
    {
        ConditionManger.Instance.SetState(GameState.Options);
    }

    void OnMenu(IUEventData uEventData)
    {
        isStarting = false;
    }

    public void SelectCharactor()
    {
        UEventData uEventData = new UEventData();
        UEventDispatcherSingleton.Instance.Invoke<CharactorSelection>(uEventData);
    }
}
