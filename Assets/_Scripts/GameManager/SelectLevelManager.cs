using RMC.Core.UEvents;
using RMC.Core.UEvents.UEventDispatcher;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using static Cinemachine.DocumentationSortingAttribute;

public class SelectLevelManager : Singleton<SelectLevelManager>
{
    public GameObject[] levelHightlighted;
    public GameObject[] levelLocked;
    public GameObject[] levelUnlocked;

    

    void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<LevelSelection>(SetHightlight);
        UEventDispatcherSingleton.Instance.AddEventListener<MenuGame>(SetHightlight);
        UEventDispatcherSingleton.Instance.AddEventListener<EndGame>(UnlockNextLevel);
    }

    public void SelectLevel(int level)
    {
        DataManager.Instance.data.currentMap = level;

        UEventData uEventData = new UEventData();
        UEventDispatcherSingleton.Instance.Invoke<LevelSelection>(uEventData);
    }

    void SetHightlight(IUEventData uEventData)
    {
        HightlightCurrentLevel();
    }

    public void ActiveCurrentLevel()
    {
        Debug.Log("a");
        for (int i = 0; i < DataManager.Instance.listLevel.data.Count; i++)
        {
            if (DataManager.Instance.listLevel.data[i].isCompleted)
            {
                levelLocked[i].SetActive(false);
                levelUnlocked[i].SetActive(true);
            }
        }
    }

    public void UnlockNextLevel(IUEventData uEventData)
    {
        levelLocked[DataManager.Instance.data.currentMap].SetActive(false);
        levelUnlocked[DataManager.Instance.data.currentMap].SetActive(true);
    }

    void HightlightCurrentLevel()
    {
        for (int i = 0; i < levelHightlighted.Length; i++)
        {
            levelHightlighted[i].gameObject.SetActive(i == DataManager.Instance.data.currentMap - 1);
        }
    }


}
