using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;


[Serializable]
public class DataPlayerBase
{
    public int numberMap;
    public int playerDirection;
}


[CreateAssetMenu(fileName = "ListDataPlayer", menuName = "ScriptableObject/DataPlayers", order = 1)]
public class ListDataPlayer : ScriptableObject
{
    public List<DataPlayerBase> dataPlayers;
}
