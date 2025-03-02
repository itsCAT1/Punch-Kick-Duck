using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DataPointManager : Singleton<DataPointManager>
{
    private void Update()
    {
        if (Input.GetKeyDown(KeyCode.S))
        {
            GainPoint();
        }
        if (Input.GetKeyDown(KeyCode.D))
        {
            Player.Instance.health.TakeDamage();
        }
    }

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
        InGameManager.Instance.lives.UpdateLivesProgress();
        InGameManager.Instance.bonusPoint.LosePoint();
        DataInGame.Instance.beatingStreak = 0;
    }

    void UpdateBestStreak()
    {
        if (DataInGame.Instance.beatingStreak > DataInGame.Instance.bestStreak)
        {
            DataInGame.Instance.bestStreak = DataInGame.Instance.beatingStreak;
        }
    }
}
