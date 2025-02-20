using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DataInGame : Singleton<DataInGame>
{
    public Transform[] playerPosition;

    public int score;
    public float beatingPoint;
    public int beatingCounter;

    public int beatingStreak;
    public int bestStreak;
}
