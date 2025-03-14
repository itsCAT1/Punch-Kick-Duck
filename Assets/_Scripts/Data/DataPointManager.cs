using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DataPointManager : Singleton<DataPointManager>
{
    private void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<PlayerHurt>(LosePoint);
    }

    public void GainPoint()
    {
        UpdatePoint();

        if (ConditionManger.Instance.currentState == GameState.Tutorial) return;

        Player.Instance.health.GainHeart();
        InGameManager.Instance.bonusPoint.GainPoint();
        DataInGame.Instance.beatingStreak++;
        UpdateBestStreak();
    }

    void UpdatePoint()
    {
        DataInGame.Instance.score += DataInGame.Instance.beatingCounter;
        InGameManager.Instance.score.UpdateScore();
    }

    public void LosePoint(IUEventData uEventData)
    {
        if (ConditionManger.Instance.currentState == GameState.Tutorial) return;

        Player.Instance.health.currentHeart = 0;
        InGameManager.Instance.lives.ShowLives();
        InGameManager.Instance.bonusPoint.LosePoint();
        DataInGame.Instance.beatingStreak = 0;
    }

    void UpdateBestStreak()
    {
        if (DataInGame.Instance.beatingStreak > DataInGame.Instance.bestStreak)
        {
            DataInGame.Instance.bestStreak = DataInGame.Instance.beatingStreak;
        }

        if (DataInGame.Instance.bestStreak > DataManager.Instance.data.bestStreak)
        {
            DataManager.Instance.data.bestStreak = DataInGame.Instance.bestStreak;

            AchievementManager.Instance.UnlockAchievement(9);
            AchievementManager.Instance.UnlockAchievement(10);
        }
    }
}
