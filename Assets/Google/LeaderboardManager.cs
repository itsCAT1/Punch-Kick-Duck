using GooglePlayGames;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SocialPlatforms.Impl;

public class LeaderboardManager : Singleton<LeaderboardManager>
{
    public string[] leaderboardIds;

    public void ReportScoreToLeaderboard(int score, string leaderboardID)
    {
        Social.ReportScore(score, leaderboardID, (bool success) =>
        {
            if (success)
            {
                Debug.Log("Update score success");
            }
            else
            {
                Debug.Log("Update score fail");
            }
        });
    }

    public void ShowLeaderboardUI()
    {
        PlayGamesPlatform.Instance.ShowLeaderboardUI();
    }

    public void UpdateDataLeaderboard(int id)
    {
        ReportScoreToLeaderboard(DataManager.Instance.listLevel.data[id].bestScore, leaderboardIds[id]);

        ReportScoreToLeaderboard(DataManager.Instance.data.totalScore, leaderboardIds[10]);
    }
}
