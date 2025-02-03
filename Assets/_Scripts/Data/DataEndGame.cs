using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DataEndGame : Singleton<DataEndGame>
{
    [Header("Score")]
    public int bestScore;

    [Header("Bonus")]
    public int bestBeatingCounter;
    public int beatingStreak;
    public int bestStreak;
    public int heartBonus;

    [Header("Total")]
    public int totalScore;
}
