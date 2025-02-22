using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SpawnEnemy : MonoBehaviour
{
    public GameObject[] enemies;
    public List<Transform> spawnPositions; 
    bool canSpawn;


    void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<InGame>(EnableSpawn);
        UEventDispatcherSingleton.Instance.AddEventListener<RestartGame>(EnableSpawn);
    }

    void EnableSpawn(IUEventData uEventData)
    {
        canSpawn = true;
    }


    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.CompareTag("Player") && canSpawn)
        {
            canSpawn = false;
            foreach (var enemyPos in spawnPositions)
            {
                GameObject enemyPrefab = enemies[Random.Range(0, enemies.Length)];

                var enemyTemp = Instantiate(enemyPrefab, enemyPos.position, Quaternion.identity, SpawnManager.Instance.spawnParent);
                SpawnManager.Instance.enemyHaveSpawned.Add(enemyTemp);
            }
        }
    }

    [ContextMenu("Add Position")]
    void AddPosition()
    {
        spawnPositions.Clear();
        Transform[] transforms = GetComponentsInChildren<Transform>();

        foreach (var t in transforms)
        {
            if (t != this.transform)
            {
                spawnPositions.Add(t);
            }
        }
    }
}
