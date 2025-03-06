using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BossThrowing : MonoBehaviour
{
    public GameObject[] fruitAvatar;
    public Transform[] fruitPosition;
    public GameObject[] fruitPrefab;

    public int fruitType;

    public void SetFruit()
    {
        fruitType = Random.Range(0, 3);
        fruitAvatar[fruitType].SetActive(true);
    }

    void CreateFruit()
    {
        fruitAvatar[fruitType].SetActive(false);
        var fruitTemp =  Instantiate(fruitPrefab[fruitType], fruitPosition[fruitType].position, this.transform.rotation, SpawnManager.Instance.spawnParent);
        SpawnManager.Instance.objectHaveSpawned.Add(fruitTemp);

        Boss.Instance.controller.throwCount--;
    }

    [ContextMenu ("reset")]
    public void OnReset()
    {
        foreach(var item in fruitAvatar)
        {
            item.gameObject.SetActive(false);
        }
    }
}
