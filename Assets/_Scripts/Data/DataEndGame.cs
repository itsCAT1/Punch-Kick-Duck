using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DataEndGame : Singleton<DataEndGame>
{
    public int totalScore;

    public void UpdateData(int newScore)
    {
        if (newScore > DataManager.Instance.currentBestScore)
        {
            DataManager.Instance.listLevel.data[DataManager.Instance.data.currentMap - 1].bestScore = newScore;
        }

        for(int i = 0; i < DataManager.Instance.listLevel.data.Count; i++)
        {
            totalScore += DataManager.Instance.listLevel.data[i].bestScore;
        }

        DataManager.Instance.data.totalScore = totalScore;
        DataManager.Instance.listLevel.data[DataManager.Instance.data.currentMap - 1].isCompleted = true;
    }
}
