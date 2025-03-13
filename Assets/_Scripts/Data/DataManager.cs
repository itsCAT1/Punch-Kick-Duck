using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DataManager : Singleton<DataManager>
{
    public DataBase data;
    public ListDataLevel listLevel;


    private void OnEnable()
    {
        LoadData();
        DataStartUp();
    }

    private void OnApplicationQuit()
    {
        SaveData();
    }

    private void OnApplicationPause(bool pause)
    {
        if (pause)
        {
            SaveData();
        }
    }

    public int currentBestScore => listLevel.data[data.currentMap - 1].bestScore;

    [ContextMenu("Save Data")]
    public void SaveData()
    {
        SaveDataBase();
        SaveDataLevel();
    }
    [ContextMenu("Load Data")]
    public void LoadData()
    {
        LoadDataBase();
        LoadDataLevel();
    }

    public void SaveDataBase()
    {
        var value = JsonUtility.ToJson(data);
        PlayerPrefs.SetString(nameof(DataBase), value);
        PlayerPrefs.Save();
    }

    public void LoadDataBase()
    {
        var value = JsonUtility.ToJson(data);
        var dataValueString = PlayerPrefs.GetString(nameof(DataBase), value);
        data = JsonUtility.FromJson<DataBase>(dataValueString);
    }

    public void SaveDataLevel()
    {
        var value = JsonUtility.ToJson(listLevel);
        PlayerPrefs.SetString(nameof(ListDataLevel), value);
        PlayerPrefs.Save();
    }

    public void LoadDataLevel()
    {
        var value = JsonUtility.ToJson(listLevel);
        var dataValueString = PlayerPrefs.GetString(nameof(ListDataLevel), value);
        listLevel = JsonUtility.FromJson<ListDataLevel>(dataValueString);
    }

    void DataStartUp()
    {
        if (!PlayerPrefs.HasKey(nameof(DataBase)))
        {
            this.data = new DataBase
            {
                currentMap = 1,
                totalCoin = 50,
                totalScore = 0,
                currentSkin = 1,
                musicVolume = 1,
                soundVolume = 1,
                attackFadeValue = 0.5f,
                screenBorder = 0,
                showTutorial = true
            };
            SaveDataBase();
        }

        if (!PlayerPrefs.HasKey(nameof(ListDataLevel)))
        {
            listLevel.data[0].isCompleted = true;
            SaveDataLevel();
        }
    }


    [ContextMenu("Reset Data")]
    public void Reset()
    {
        PlayerPrefs.DeleteAll();

        data = new DataBase();
    }

    [ContextMenu("Active All")]
    public void UnlockAllLevel()
    {
        foreach (var item in listLevel.data)
        {
            item.isCompleted = true;
        }
    }
}
