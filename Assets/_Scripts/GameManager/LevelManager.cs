using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LevelManager : Singleton<LevelManager>
{
    public GameObject[] levelEnviroment;


    void Start()
    {
        ActiveCurrentLevel();
        UEventDispatcherSingleton.Instance.AddEventListener<MenuGame>(UpdateOnStart);
        UEventDispatcherSingleton.Instance.AddEventListener<LevelSelection>(UpdateOnStart);

    }

    void UpdateOnStart(IUEventData uEventData)
    {
        ActiveCurrentLevel();
    }

    public void ActiveCurrentLevel()
    {
        var indexMap = DataManager.Instance.data.currentMap - 1;

        for (int i = 0; i < levelEnviroment.Length; i++)
        {
            levelEnviroment[i].SetActive(i == indexMap);
        }
    }

    public void ActiveNextLevel()
    {
        var indexMap = DataManager.Instance.data.currentMap;

        levelEnviroment[indexMap].SetActive(true);
    }

    public void StartTransition()
    {
        StartCoroutine(SetActive());
    }

    IEnumerator SetActive()
    {
        yield return new WaitForSeconds(3);

        ActiveNextLevel();

        yield return new WaitForSeconds(12);

        ActiveCurrentLevel();
    }
}
