using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SpawnEnemy : MonoBehaviour
{
    public GameObject[] enemies;
    public Transform[] spawnPosition;

    public Transform spawnParent;

    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.CompareTag("Player"))
        {
            Instantiate(enemies[Random.Range(0 , enemies.Length)], spawnPosition[Random.Range(0, 1)].position, Quaternion.identity, spawnParent);
            Destroy(this);
        }
    }
}
