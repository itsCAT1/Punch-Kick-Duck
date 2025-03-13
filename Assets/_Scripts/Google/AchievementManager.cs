using GooglePlayGames;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AchievementManager : Singleton<AchievementManager>
{
    public ListDataProgress progressData;
    public ListDataQuest questData;

    private void OnEnable()
    {
        LoadDataProgress();
    }

    private void OnApplicationQuit()
    {
        SaveDataProgress();
    }

    public bool UnlockAchievement(int id)
    {
        UpdateDataAchievement(id);

        var quest = questData.questData.Find(q => q.id == id);
        var progress = progressData.dataProgresses.Find(p => p.id == id);

        if (quest.targetValue > 0)
        {
            if (progress.currentValue >= quest.targetValue && !progress.isCompleted)
            {
                progress.isCompleted = true; 
                AchievementHandler.Instance.UnlockAchievement(id);
                SaveDataProgress();
                return true;
            }
            if (!progress.isCompleted) AchievementHandler.Instance.ReportProgress(id);

            return progress.currentValue >= quest.targetValue;
        }
        else
        {
            if (!progress.isCompleted)
            {
                progress.isCompleted = true;
                AchievementHandler.Instance.UnlockAchievement(id);
                SaveDataProgress();
                return true;
            }
            return progress.isCompleted;
        }
    }

    public void UpdateDataAchievement(int id)
    {
        switch (id)
        {
            case 8:
                progressData.dataProgresses[id].currentValue = SkinManager.Instance.listSkinOwned.skins.Count - 1;
                break;
            case 9:
            case 10:
                progressData.dataProgresses[id].currentValue = DataManager.Instance.data.bestStreak;
                break;
            case 11:
                progressData.dataProgresses[id].currentValue = DataManager.Instance.data.totalScore;
                break;
        }
    }

    public void SaveDataProgress()
    {
        var value = JsonUtility.ToJson(progressData);
        PlayerPrefs.SetString(nameof(ListDataProgress), value);
        PlayerPrefs.Save();
    }

    public void LoadDataProgress()
    {
        var value = JsonUtility.ToJson(progressData);
        var dataValueString = PlayerPrefs.GetString(nameof(ListDataProgress), value);
        progressData = JsonUtility.FromJson<ListDataProgress>(dataValueString);
    }
}
