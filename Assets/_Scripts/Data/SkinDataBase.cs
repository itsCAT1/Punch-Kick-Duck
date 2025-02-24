using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[Serializable]
public class DataSkin
{
    public int id;
    public int coin;
}


[CreateAssetMenu(fileName = "SkinDataBase", menuName = "ScriptableObject/DataSkins", order = 1)]
public class SkinDataBase : ScriptableObject
{
    public List<DataSkin> dataSkins;
}
