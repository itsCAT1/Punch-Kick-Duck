using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Lean.Pool;

public class SpawnManager : MonoBehaviour
{
    public GameObject enemyPrefab;
    public float durationSpawn;

    void Start()
    {
        StartCoroutine(SpawnEnemy());
    }

    IEnumerator SpawnEnemy()
    {
        while (true)
        {
            LeanPool.Spawn(enemyPrefab);
            yield return new WaitForSeconds(durationSpawn);
        }
        
    }
}
