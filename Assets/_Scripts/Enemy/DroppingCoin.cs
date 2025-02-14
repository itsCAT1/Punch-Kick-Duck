using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DroppingCoin : MonoBehaviour
{
    public float dropChance = 0.3f;
    public GameObject coinPrefab;


    private void Update()
    {
        if (Input.GetKeyDown(KeyCode.Space))
        {
            RandomDropCoin();
        }
    }

    public void RandomDropCoin()
    {
        float randomValue = Random.value;
        if (randomValue <= dropChance)
        {
            SpawnCoin();
        }
    }
    void SpawnCoin()
    {
        Instantiate(coinPrefab, this.transform.position, Quaternion.Euler(90, 0, 0));
    }
}
