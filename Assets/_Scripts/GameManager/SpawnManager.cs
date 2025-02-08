using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SpawnManager : Singleton<SpawnManager>
{
    public List<GameObject> enemyHaveSpawned;

    public bool enemyHaveWeapon = false;
}
