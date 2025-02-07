using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SpawnEnemy : MonoBehaviour
{
    public GameObject[] enemies;
    public List<Transform> spawnPositions; 
    public Transform spawnParent;
    bool canSpawn;

    public List<GameObject> enemiesHaveSpawned;

    void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<StartGame>(EnableSpawn);
        UEventDispatcherSingleton.Instance.AddEventListener<RestartGame>(EnableSpawn);
        UEventDispatcherSingleton.Instance.AddEventListener<RestartGame>(ResetLevel);
        UEventDispatcherSingleton.Instance.AddEventListener<LevelTransition>(ResetLevel);
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
                var enemyTemp = Instantiate(enemies[Random.Range(0, enemies.Length)], enemyPos.position, Quaternion.identity);
                enemiesHaveSpawned.Add(enemyTemp);
            }
        }
    }

    void ResetLevel(IUEventData uEventData)
    {
        foreach (var enemy in enemiesHaveSpawned)
        {
            Destroy(enemy.gameObject);
        }
        enemiesHaveSpawned.Clear();
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
