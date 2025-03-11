using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Reflection;
using UnityEngine;

[Serializable]
public class SkinOwned
{
    public int indexSkin;
    public string name;
}

[Serializable]
public class SkinOwnedList
{
    public List<SkinOwned> list;
}

public class SkinManager : Singleton<SkinManager>
{
    public SkinOwnedList listSkinOwned;
    public SkinDataBase skin;

    public AudioSource soundUnbox;
    public AudioSource soundNotAlow;

    private void Start()
    {
        LoadDataSkin();
        SkinStartUp();
    }

    private void OnApplicationQuit()
    {
        SaveDataSkin();
    }

    public bool CheckSkin(int index)
    {
        return listSkinOwned.list.Exists(skin => skin.indexSkin == index);
    }


    DataSkin GetDataSkin(int index)
    {
        return skin.dataSkins.Find(skin => skin.id == index);
    }

    public void PurchaseSkinByCoin(int index)
    {
        var dataSkin = GetDataSkin(index);

        if (DataManager.Instance.data.totalCoin >= dataSkin.coin && !CheckSkin(index))
        {
            DataManager.Instance.data.totalCoin -= dataSkin.coin;

            SetSkin(index);
        }

        else soundNotAlow.Play();
    }

    public void PurchaseSkinByMoney(int index)
    {
        if (!CheckSkin(index))
        {
            SetSkin(index);
        }
    }

    void SetSkin(int index)
    {
        var owned = new SkinOwned
        {
            indexSkin = index,
            name = "Skin: " + index
        };
        listSkinOwned.list.Add(owned);

        soundUnbox.Play();
        SaveDataSkin();

        AchievementManager.Instance.UnlockAchievement(0);
        AchievementManager.Instance.UnlockAchievement(8);
    }

    void SkinStartUp()
    {
        if (!CheckSkin(1))
        {
            var owned = new SkinOwned
            {
                indexSkin = 1,
                name = "Skin: " + 1
            };
            listSkinOwned.list.Add(owned);
            SaveDataSkin();
        }
    }

    public void SaveDataSkin()
    {
        var value = JsonUtility.ToJson(listSkinOwned);
        PlayerPrefs.SetString(nameof(SkinOwnedList), value);
        PlayerPrefs.Save();
    }

    public void LoadDataSkin()
    {
        var value = JsonUtility.ToJson(listSkinOwned);
        var dataValueString = PlayerPrefs.GetString(nameof(SkinOwnedList), value);
        listSkinOwned = JsonUtility.FromJson<SkinOwnedList>(dataValueString);
    }

}
