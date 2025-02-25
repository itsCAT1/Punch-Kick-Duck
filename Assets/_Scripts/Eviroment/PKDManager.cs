using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PKDManager : MonoBehaviour
{
    public Transform[] positionSpawned;
    public GameObject[] pkdPrefab;
    public List<GameObject> pkdPrefabList;

    private void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<LevelSelection>(SetPosition);
        UEventDispatcherSingleton.Instance.AddEventListener<MenuGame>(SetPosition);
        UEventDispatcherSingleton.Instance.AddEventListener<RestartGame>(OnRestart);
    }

    void SetPosition(IUEventData uEventData)
    {
        DestroyPKD();

        int index = DataManager.Instance.data.currentMap - 1;

        var spawnPosition = positionSpawned[index].position;

        var pkdTemp = Instantiate(pkdPrefab[index], spawnPosition, Quaternion.identity, this.transform);
        pkdPrefabList.Add(pkdTemp);
    }

    void OnRestart(IUEventData uEventData)
    {
        DestroyPKD();
    }

    private void DestroyPKD()
    {
        if (pkdPrefabList.Count > 0)
        {
            foreach (var obj in pkdPrefabList)
            {
                if (obj != null) Destroy(obj);
            }
            pkdPrefabList.Clear();
        }
    }
}
