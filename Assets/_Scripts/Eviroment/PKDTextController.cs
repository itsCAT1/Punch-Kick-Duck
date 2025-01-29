using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PKDTextController : MonoBehaviour
{
    public Transform[] positionSpawned;
    public GameObject[] pkdPrefab;

    private void Start()
    {
        PositionOnStart();
    }

    void PositionOnStart()
    {
        int index = DataBase.Instance.currentMap - 1;
        var spawnPosition = positionSpawned[index].position;
        Debug.Log(spawnPosition);
        Instantiate(pkdPrefab[index], spawnPosition, Quaternion.identity, this.transform);
    }
}
