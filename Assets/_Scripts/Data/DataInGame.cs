using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DataInGame : Singleton<DataInGame>
{
    public bool isStartGame;

    [Header("Score")]
    public int score;
    public int maxScore;

    [Header("Bonus")]
    public float beatingPoint;
    public int beatingCounter;
    public int beatingStreak;
    public int maxStreak;

    [Header("Total")]
    public int totalScore;
}
