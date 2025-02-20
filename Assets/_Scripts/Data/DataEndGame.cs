using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DataEndGame : Singleton<DataEndGame>
{

    public void UpdateData(int newScore, int totalScore)
    {
        if (newScore > DataManager.Instance.currentBestScore)
        {
            DataManager.Instance.listLevel.data[DataManager.Instance.data.currentMap - 1].bestScore = newScore;
        }

        DataManager.Instance.data.totalScore = totalScore;
        DataManager.Instance.listLevel.data[DataManager.Instance.data.currentMap - 1].isCompleted = true;
    }
}
