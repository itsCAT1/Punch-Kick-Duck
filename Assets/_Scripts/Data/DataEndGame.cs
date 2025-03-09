using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DataEndGame : Singleton<DataEndGame>
{
    int totalScore;

    public void UpdateData(int newScore)
    {
        int indexMap = DataManager.Instance.data.currentMap - 1;

        if (newScore > DataManager.Instance.currentBestScore)
        {
            DataManager.Instance.listLevel.data[indexMap].bestScore = newScore;
        }

        for(int i = 0; i < DataManager.Instance.listLevel.data.Count; i++)
        {
            totalScore += DataManager.Instance.listLevel.data[i].bestScore;
        }

        DataManager.Instance.data.totalScore = totalScore;
        DataManager.Instance.listLevel.data[indexMap].isCompleted = true;

        UpdateDataGoogle(indexMap);
    }

    void UpdateDataGoogle(int index)
    {
        LeaderboardManager.Instance.UpdateDataLeaderboard(index);
        AchievementManager.Instance.UnlockAchievement(11);
    }
}
