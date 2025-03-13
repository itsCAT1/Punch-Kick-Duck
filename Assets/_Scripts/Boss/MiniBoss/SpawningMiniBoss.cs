using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Lean.Common;

public class SpawningMiniBoss : Singleton<SpawningMiniBoss>
{
    public float timeCounter;
    public GameObject miniBossPrefab;
    public Transform[] spawnPosition;

    Coroutine countingCoroutine;

    void Start()
    {
        SetTimer();

        UEventDispatcherSingleton.Instance.AddEventListener<MenuGame>(SetTimer);
        UEventDispatcherSingleton.Instance.AddEventListener<RestartGame>(SetTimer);
        UEventDispatcherSingleton.Instance.AddEventListener<LevelTransition>(SetTimer);
        UEventDispatcherSingleton.Instance.AddEventListener<LevelSelection>(SetTimer);

        UEventDispatcherSingleton.Instance.AddEventListener<InGame>(StartCounting);
        UEventDispatcherSingleton.Instance.AddEventListener<PlayerDeath>(StopCounting);
        UEventDispatcherSingleton.Instance.AddEventListener<MenuGame>(StopCounting);
        UEventDispatcherSingleton.Instance.AddEventListener<EndGame>(StopCounting);
    }

    void SetTimer()
    {
        if(DataManager.Instance.data != null)
        {
            var dataPlayer = Player.Instance.controller.GetDataPlayer(DataManager.Instance.data.currentMap);
            timeCounter = dataPlayer.timeSpawnBoss;
        }
    }

    void StartCounting(IUEventData uEventData)
    {
        if(DataManager.Instance.data.currentMap == 1 || DataManager.Instance.data.currentMap == 10)
        {
            return;
        }

        if (countingCoroutine != null)
        {
            StopCoroutine(countingCoroutine);
        }

        countingCoroutine = StartCoroutine(StartCountingTime());
    }

    IEnumerator StartCountingTime()
    {
        var dataPlayer = Player.Instance.controller.GetDataPlayer(DataManager.Instance.data.currentMap);
        timeCounter = dataPlayer.timeSpawnBoss;

        while (timeCounter > 0)
        {
            InGameManager.Instance.miniBoss.UpdateTimer();
            timeCounter -= Time.deltaTime;
            yield return null;
            
        }
        InGameManager.Instance.miniBoss.UpdateTimer();
        Spawn();
    }

    void Spawn()
    {
        var bossTemp = Instantiate(miniBossPrefab, spawnPosition[DataManager.Instance.data.currentMap - 1].position, Quaternion.identity, SpawnManager.Instance.spawnParent);
        SpawnManager.Instance.objectHaveSpawned.Add(bossTemp);
    }

    void StopCounting(IUEventData uEventData)
    {
        if (countingCoroutine != null)
        {
            StopCoroutine(countingCoroutine);
        }
    }

    void SetTimer(IUEventData uEventData)
    {
        SetTimer();
    }
}
