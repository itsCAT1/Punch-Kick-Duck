using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ConditionManger : Singleton<ConditionManger>
{
    public bool isStartGame;
    public bool isEndGame;

    public GameObject inGameUI;
    public GameObject endGameUI;
    public GameObject attackUI;

    void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<StartGame>(ShowStartGame);
        UEventDispatcherSingleton.Instance.AddEventListener<EndGame>(ShowEndGame);
        UEventDispatcherSingleton.Instance.AddEventListener<ChangeLevel>(ShowInGame);
    }

    void ShowStartGame(IUEventData uEventData)
    {
        isStartGame = true;
        isEndGame = false;
    }

    void ShowEndGame(IUEventData uEventData)
    {
        isStartGame = false;
        isEndGame = true;
        attackUI.SetActive(false);
        endGameUI.SetActive(true);
    }

    void ShowInGame(IUEventData uEventData)
    {
        isStartGame = true;
        isEndGame = false;
        attackUI.SetActive(true);
        endGameUI.SetActive(false);
    }
}
