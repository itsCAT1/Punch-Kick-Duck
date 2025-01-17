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
            foreach (var enemyPos  in spawnPosition)
            {
                Instantiate(enemies[Random.Range(0, enemies.Length)], enemyPos.position, Quaternion.identity, spawnParent);
            }
            
            Destroy(this.gameObject);
        }
    }
}
