﻿using RMC.Core.UEvents.UEventDispatcher;
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

    Coroutine countingCoroutine;

    void Start()
    {
        GetTimer();
        UEventDispatcherSingleton.Instance.AddEventListener<StartGame>(StartCounting);
        UEventDispatcherSingleton.Instance.AddEventListener<RestartGame>(ResetCounting);
        UEventDispatcherSingleton.Instance.AddEventListener<LevelTransition>(ResetCounting);
        UEventDispatcherSingleton.Instance.AddEventListener<PlayerDeath>(GameOver);
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

        StopCounting();
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
        var bossTemp = Instantiate(miniBossPrefab, spawnPosition[DataManager.Instance.data.currentMap - 1].position, Quaternion.identity, SpawnManager.Instance.spawnParent);
        SpawnManager.Instance.enemyHaveSpawned.Add(bossTemp);
    }

    void StopCounting()
    {
        if (countingCoroutine != null)
        {
            StopCoroutine(countingCoroutine);
        }
    }

    void ResumeCounting()
    {
        countingCoroutine = StartCoroutine(StartCountingTime());
    }


    void ResetCounting(IUEventData uEventData)
    {
        StopCounting();

        GetTimer();

        if (DataManager.Instance.data.currentMap == 1 || DataManager.Instance.data.currentMap == 10)
        {
            return;
        }

        ResumeCounting();
    }

    void GameOver(IUEventData uEventData)
    {
        StopCounting();
    }
}
