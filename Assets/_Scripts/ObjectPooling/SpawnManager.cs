using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Lean.Pool;

public class SpawnManager : MonoBehaviour
{
    public GameObject[] enemiesPrefab;

    public void SpawnPunch()
    {
        Instantiate(enemiesPrefab[0], this.transform.position, Quaternion.identity);
    }

    public void SpawnKick()
    {
        Instantiate(enemiesPrefab[1], this.transform.position, Quaternion.identity);
    }

    public void SpawnDuck()
    {
        Instantiate(enemiesPrefab[2], this.transform.position, Quaternion.identity);
    }
}
