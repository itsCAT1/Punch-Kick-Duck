using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PKDPosition : MonoBehaviour
{
    public Transform[] positionSpawned;
    public GameObject[] pkdPrefab;
    public List<GameObject> pkdPrefabList;

    private void Start()
    {
        PositionOnStart();
        UEventDispatcherSingleton.Instance.AddEventListener<LevelSelection>(SetPosition);
    }

    void PositionOnStart()
    {
        int index = DataManager.Instance.data.currentMap - 1;
        var spawnPosition = positionSpawned[index].position;

        var pkdTemp = Instantiate(pkdPrefab[index], spawnPosition, Quaternion.identity, this.transform);
        pkdPrefabList.Add(pkdTemp);
    }

    void SetPosition(IUEventData uEventData)
    {
        Destroy(pkdPrefabList[0].gameObject);
        pkdPrefabList.Clear();

        int index = DataManager.Instance.data.currentMap - 1;
        var spawnPosition = positionSpawned[index].position;

        var pkdTemp = Instantiate(pkdPrefab[index], spawnPosition, Quaternion.identity, this.transform);
        pkdPrefabList.Add(pkdTemp);
    }
}
