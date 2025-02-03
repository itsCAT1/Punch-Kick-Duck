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


    void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<StartGame>(ShowStartGame);
        UEventDispatcherSingleton.Instance.AddEventListener<EndGame>(ShowEndGame);
    }

    void ShowEndGame(IUEventData uEventData)
    {
        isStartGame = false;
        isEndGame = true;
        endGameUI.SetActive(true);
    }

    void ShowStartGame(IUEventData uEventData)
    {
        isStartGame = true;
        isEndGame = false;
        endGameUI.SetActive(false);
    }
}
