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

    void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<StartGame>(EnableSpawn);
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
                Instantiate(enemies[Random.Range(0, enemies.Length)], enemyPos.position, Quaternion.identity, spawnParent);
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
