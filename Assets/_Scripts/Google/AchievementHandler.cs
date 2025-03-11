using GooglePlayGames;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AchievementHandler : Singleton<AchievementHandler>
{
    public string[] achievementIds;

    public void ReportAchievement(string achievementID, float progressPercentage)
    {
        Social.ReportProgress(achievementID, progressPercentage * 100, (bool success) =>
        {
            if (success)
            {
                Debug.Log("Update progress success");
            }
            else
            {
                Debug.Log("Update progress fail");
            }
        });
    }

    public void ShowAchievements()
    {
        PlayGamesPlatform.Instance.ShowAchievementsUI();
    }

    public void ReportProgress(int id)
    {
        var progress = AchievementManager.Instance.progressData.dataProgresses.Find(p => p.id == id);
        var quest = AchievementManager.Instance.questData.questData.Find(p => p.id == id);

        float progressPercentage = (float)progress.currentValue / quest.targetValue;

        ReportAchievement(achievementIds[id], progressPercentage);
        Debug.Log(id + " " + progressPercentage);
    }

    public void UnlockAchievement(int id)
    {
        var progress = AchievementManager.Instance.progressData.dataProgresses.Find(p => p.id == id);
        Debug.Log("Unlock achievement " + id);

        ReportAchievement(achievementIds[id], 1);
    }
}
