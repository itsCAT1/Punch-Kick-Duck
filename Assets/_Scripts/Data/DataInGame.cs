using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DataInGame : Singleton<DataInGame>
{
    public Transform[] playerPosition;
    public Transform[] positionOnBoss;
    public bool inRoom;

    public int score;
    public float beatingPoint;
    public int beatingCounter;

    public int beatingStreak;
    public int bestStreak;

    private void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<MenuGame>(OnMenu);

        UEventDispatcherSingleton.Instance.AddEventListener<RestartGame>(ResetValue);
        UEventDispatcherSingleton.Instance.AddEventListener<LevelTransition>(ResetValue);
        UEventDispatcherSingleton.Instance.AddEventListener<MenuGame>(ResetValue);

    }

    void OnMenu(IUEventData uEventData)
    {
        inRoom = false;
    }

    public void ResetValue(IUEventData uEventData)
    {
        beatingPoint = 0;
        beatingCounter = 1;
        beatingStreak = 0;
        bestStreak = 0;
        score = 0;
    }
}
