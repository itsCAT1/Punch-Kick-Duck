using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SpawnManager : Singleton<SpawnManager>
{
    public List<GameObject> enemyHaveSpawned;
    public Transform spawnParent;

    void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<RestartGame>(ClearEnemy);
        UEventDispatcherSingleton.Instance.AddEventListener<MenuGame>(ClearEnemy);
        UEventDispatcherSingleton.Instance.AddEventListener<LevelTransition>(ClearEnemy);
    }


    void ClearEnemy(IUEventData uEventData)
    {
        foreach (var enemy in enemyHaveSpawned)
        {
            Destroy(enemy.gameObject);
        }
        enemyHaveSpawned.Clear();
    }
}
