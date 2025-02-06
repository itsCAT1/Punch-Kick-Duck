using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SpawningMiniBoss : Singleton<SpawningMiniBoss>
{
    public int timeCounter;
    public GameObject miniBossPrefab;
    public Transform[] spawnPosition;

    void Start()
    {
        GetTimer();
        UEventDispatcherSingleton.Instance.AddEventListener<StartGame>(StartCounting);
    }

    void GetTimer()
    {
        var dataPlayer = Player.Instance.controller.GetDataPlayer(DataManager.Instance.data.currentMap);
        timeCounter = dataPlayer.timeSpawnBoss;
    }

    void StartCounting(IUEventData uEventData)
    {
        if(DataManager.Instance.data.currentMap == 1 || DataManager.Instance.data.currentMap == 10)
        {
            return;
        }
        StartCoroutine(StartCountingTime());
    }

    IEnumerator StartCountingTime()
    {
        while(timeCounter > 0)
        {
            yield return new WaitForSeconds(1);
            timeCounter--;
        }
        Spawn();
    }

    void Spawn()
    {
        Instantiate(miniBossPrefab, spawnPosition[DataManager.Instance.data.currentMap - 1].position, Quaternion.identity);
    }
}
