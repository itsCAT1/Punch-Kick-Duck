using RMC.Core.UEvents;
using RMC.Core.UEvents.UEventDispatcher;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SelectLevelManager : MonoBehaviour
{
    public GameObject[] levelHightlighted;

    void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<LevelSelection>(SetPlayerPosition);
    }

    public void SelectLevel(int level)
    {
        DataManager.Instance.data.currentMap = level;
        Debug.Log(DataManager.Instance.data.currentMap);

        UEventData uEventData = new UEventData();
        UEventDispatcherSingleton.Instance.Invoke<LevelSelection>(uEventData);
    }

    void SetPlayerPosition(IUEventData uEventData)
    {
        Player.Instance.controller.SetPosition();
        Player.Instance.controller.SetDirection();
    }
}
