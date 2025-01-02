using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Lean.Pool;

public class SpawnManager : MonoBehaviour
{
    public GameObject[] enemiesPrefab;
    public float durationSpawn;

    void Start()
    {
        StartCoroutine(SpawnEnemy());
    }

    IEnumerator SpawnEnemy()
    {
        while (true)
        {
            //Instantiate(enemyPrefab, this.transform.position, Quaternion.identity);
            LeanPool.Spawn(enemiesPrefab[Random.Range(0, enemiesPrefab.Length)]);

            yield return new WaitForSeconds(durationSpawn);
        }
        
    }
}
