using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Lean.Common;

public class SpawningMiniBoss : Singleton<SpawningMiniBoss>
{
    public int timeCounter;
    public GameObject miniBossPrefab;
    public Transform[] spawnPosition;

    public List<GameObject> bossHaveSpawned;
    Coroutine countingCoroutine;

    void Start()
    {
        GetTimer();
        UEventDispatcherSingleton.Instance.AddEventListener<StartGame>(StartCounting);
        UEventDispatcherSingleton.Instance.AddEventListener<RestartGame>(ResetLevel);
        UEventDispatcherSingleton.Instance.AddEventListener<LevelTransition>(ResetLevel);
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

        if (countingCoroutine != null)
        {
            StopCoroutine(countingCoroutine);
        }

        countingCoroutine = StartCoroutine(StartCountingTime());
    }

    IEnumerator StartCountingTime()
    {
        while (timeCounter > 0)
        {
            yield return new WaitForSeconds(1);
            timeCounter--;
        }
        Spawn();
    }

    void Spawn()
    {
        var bossTemp = Instantiate(miniBossPrefab, spawnPosition[DataManager.Instance.data.currentMap - 1].position, Quaternion.identity);
        bossHaveSpawned.Add(bossTemp);
    }

    public void ResetLevel(IUEventData uEventData)
    {
        if (countingCoroutine != null)
        {
            StopCoroutine(countingCoroutine);
        }

        GetTimer();

        foreach (var miniboss in bossHaveSpawned)
        {
            Destroy(miniboss.gameObject);
        }
        bossHaveSpawned.Clear();

        if (DataManager.Instance.data.currentMap == 1 || DataManager.Instance.data.currentMap == 10)
        {
            return;
        }
        countingCoroutine = StartCoroutine(StartCountingTime());
    }
}
