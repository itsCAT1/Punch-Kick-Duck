using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PKDPosition : MonoBehaviour
{
    public Transform[] positionSpawned;
    public GameObject[] pkdPrefab;

    private void Start()
    {
        PositionOnStart();
    }

    void PositionOnStart()
    {
        int index = DataManager.Instance.data.currentMap - 1;
        var spawnPosition = positionSpawned[index].position;
        Instantiate(pkdPrefab[index], spawnPosition, Quaternion.identity, this.transform);
    }
}
