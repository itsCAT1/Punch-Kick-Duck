using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SpawningBoss : MonoBehaviour
{
    public GameObject bossPrefab;
    public Transform spawnPosition;

    public List<GameObject> bossHaveSpawned;


    private void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<MenuGame>(SpawnOnStart);

        UEventDispatcherSingleton.Instance.AddEventListener<RestartGame>(SpawnOnStart);
    }

    void SpawnOnStart(IUEventData uEventData)
    {
        ClearBoss();

        Spawn();
    }
    void Spawn()
    {
        Debug.Log("spawn");
        Debug.Log(bossHaveSpawned.Count);
        if (DataManager.Instance.data.currentMap == 10 && bossHaveSpawned.Count == 0)
        {
            var bossTemp = Instantiate(bossPrefab, spawnPosition.position, Quaternion.Euler(0, -90, 0), SpawnManager.Instance.spawnParent);
            bossHaveSpawned.Add(bossTemp);
        }
    }

    void ClearBoss()
    {
        if(bossHaveSpawned.Count > 0)
        {
            foreach (var boss in bossHaveSpawned)
            {
                Destroy(boss.gameObject);
            }
            bossHaveSpawned.Clear();
        }
    }
}
