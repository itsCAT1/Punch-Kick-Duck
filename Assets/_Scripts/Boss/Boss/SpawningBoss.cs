using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SpawningBoss : Singleton<SpawningBoss>
{
    public GameObject bossPrefab;
    public Transform spawnPosition;


    private void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<MenuGame>(SpawnOnStart);

        UEventDispatcherSingleton.Instance.AddEventListener<RestartGame>(SpawnOnStart);

        UEventDispatcherSingleton.Instance.AddEventListener<LevelSelection>(SpawnOnStart);
    }

    void SpawnOnStart(IUEventData uEventData)
    {
        if(DataManager.Instance.data.currentMap == 10)
        {
            Spawn();
        }
        else
        {
            Destroy();
        }
    }

    void Spawn()
    {
        var bossTemp = Instantiate(bossPrefab, spawnPosition.position, Quaternion.Euler(0, -90, 0), SpawnManager.Instance.spawnParent);
    }

    [ContextMenu ("spawn 1")]
    void Spawn1()
    {
        var bossTemp = Instantiate(bossPrefab, spawnPosition.position, Quaternion.Euler(0, -90, 0), SpawnManager.Instance.spawnParent);
    }

    void Destroy()
    {
        if(Boss.Instance != null) Destroy(Boss.Instance.gameObject);
    }
}
