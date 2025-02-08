using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SpawnEnemy : MonoBehaviour
{
    public GameObject[] enemies;
    public GameObject[] enemiesHaveWeapon;
    public List<Transform> spawnPositions; 
    public Transform spawnParent;
    bool canSpawn;



    void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<StartGame>(EnableSpawn);
        UEventDispatcherSingleton.Instance.AddEventListener<RestartGame>(EnableSpawn);
        UEventDispatcherSingleton.Instance.AddEventListener<RestartGame>(ClearEnemy);
        UEventDispatcherSingleton.Instance.AddEventListener<LevelTransition>(ClearEnemy);
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
                if (!SpawnManager.Instance.enemyHaveWeapon)
                {
                    GameObject enemyPrefab = enemiesHaveWeapon[Random.Range(0, enemiesHaveWeapon.Length)];
                    var enemyTemp = Instantiate(enemyPrefab, enemyPos.position, Quaternion.identity);
                    SpawnManager.Instance.enemyHaveSpawned.Add(enemyTemp);
                }

                else
                {
                    GameObject enemyPrefab = enemies[Random.Range(0, enemies.Length)];
                    var enemyTemp = Instantiate(enemyPrefab, enemyPos.position, Quaternion.identity);
                    SpawnManager.Instance.enemyHaveSpawned.Add(enemyTemp);
                }

                CheckEnemyHaveWeapon();
            }
        }
    }

    void CheckEnemyHaveWeapon()
    {
        foreach (var enemy in SpawnManager.Instance.enemyHaveSpawned)
        {
            if (enemy.GetComponent<EnemyController>() == null) return;

            if (enemy.GetComponent<EnemyController>().haveBottle || enemy.GetComponent<EnemyController>().haveCart)
            {
                SpawnManager.Instance.enemyHaveWeapon = true;
                break;
            }
            else
            {
                SpawnManager.Instance.enemyHaveWeapon = false;
            }
        }
    }


    void ClearEnemy(IUEventData uEventData)
    {
        foreach (var enemy in SpawnManager.Instance.enemyHaveSpawned)
        {
            Destroy(enemy.gameObject);
        }
        SpawnManager.Instance.enemyHaveSpawned.Clear();
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
