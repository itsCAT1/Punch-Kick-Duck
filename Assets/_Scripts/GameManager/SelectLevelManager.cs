using RMC.Core.UEvents;
using RMC.Core.UEvents.UEventDispatcher;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SelectLevelManager : Singleton<SelectLevelManager>
{
    public GameObject[] levelHightlighted;
    public GameObject[] levelLocked;
    public GameObject[] levelUnlocked;

    void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<LevelSelection>(SetHightlight);
        UEventDispatcherSingleton.Instance.AddEventListener<MenuGame>(SetHightlight);
    }

    public void SelectLevel(int level)
    {
        if (!DataManager.Instance.listLevel.data[level - 1].isCompleted)
        {
            return;
        }
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
        for (int i = 0; i < DataManager.Instance.listLevel.data.Count; i++)
        {
            if (DataManager.Instance.listLevel.data[i].isCompleted)
            {
                levelLocked[i].SetActive(false);
                levelUnlocked[i].SetActive(true);
            }
        }

        HightlightCurrentLevel();
    }

    void HightlightCurrentLevel()
    {
        for (int i = 0; i < levelHightlighted.Length; i++)
        {
            levelHightlighted[i].gameObject.SetActive(i == DataManager.Instance.data.currentMap - 1);
        }
    }
}
