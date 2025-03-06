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

    public int currentBestScore => listLevel.data[data.currentMap - 1].bestScore;

    [ContextMenu("Save Data")]
    public void SaveData()
    {
        SaveDataBase();
        SaveDataProgress();
    }
    [ContextMenu("Load Data")]
    public void LoadData()
    {
        LoadDataBase();
        LoadDataProgress();
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

    public void SaveDataProgress()
    {
        var value = JsonUtility.ToJson(listLevel);
        PlayerPrefs.SetString(nameof(ListDataLevel), value);
        PlayerPrefs.Save();
    }

    public void LoadDataProgress()
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
                totalCoin = 0,
                totalScore = 0,
                currentSkin = 1,
                showTutorial = true
            };
            SaveDataBase();
        }

        if (!PlayerPrefs.HasKey(nameof(ListDataLevel)))
        {
            listLevel.data[0].isCompleted = true;
            SaveDataProgress();
        }
    }


    [ContextMenu("Reset Data")]
    public void Reset()
    {
        PlayerPrefs.DeleteAll();

        data = new DataBase();
    }

    [ContextMenu("Active All")]
    public void Active()
    {
        foreach (var item in listLevel.data)
        {
            item.isCompleted = true;
        }
    }
}
