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
    }

    void OnMenu(IUEventData uEventData)
    {
        inRoom = false;
    }
}
