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
        LoadDataProgress();
    }

    private void OnApplicationQuit()
    {
        SaveData();
        SaveDataProgress();
    }

    public int currentBestScore => listLevel.data[data.currentMap - 1].bestScore;

    [ContextMenu("Save Data")]
    public void SaveData()
    {
        SaveDataBase();
    }
    [ContextMenu("Load Data")]
    public void LoadData()
    {
        LoadDataBase();
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
}
