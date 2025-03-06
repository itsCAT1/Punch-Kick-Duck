using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SpawnManager : Singleton<SpawnManager>
{
    public List<GameObject> objectHaveSpawned;
    public Transform spawnParent;

    public GameObject spawnInGame;
    public GameObject spawnTutorial;

    void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<RestartGame>(ClearObject);
        UEventDispatcherSingleton.Instance.AddEventListener<MenuGame>(ClearObject);
        UEventDispatcherSingleton.Instance.AddEventListener<LevelTransition>(ClearObject);

        UEventDispatcherSingleton.Instance.AddEventListener<InGame>(CheckState);
        UEventDispatcherSingleton.Instance.AddEventListener<Tutorial>(CheckState);
    }

    void CheckState(IUEventData uEventData)
    {
        if(ConditionManger.Instance.currentState == GameState.Tutorial)
        {
            spawnTutorial.SetActive(true);
            spawnInGame.SetActive(false);
        }
        else if(ConditionManger.Instance.currentState == GameState.InGame)
        {
            spawnTutorial.SetActive(false);
            spawnInGame.SetActive(true);
        }
    }

    void ClearObject(IUEventData uEventData)
    {
        foreach (var enemy in objectHaveSpawned)
        {
            Destroy(enemy.gameObject);
        }
        objectHaveSpawned.Clear();
    }
}
