using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;


[Serializable]
public class DataPlayer
{
    public int numberMap;
    public int playerDirection;
    public int maxHeart;
    public int timeSpawnBoss;
}


[CreateAssetMenu(fileName = "PlayerDataBase", menuName = "ScriptableObject/DataPlayers", order = 1)]
public class PlayerDataBase : ScriptableObject
{
    public List<DataPlayer> dataPlayers;
}
