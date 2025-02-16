using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DataPointManager : Singleton<DataPointManager>
{

    public void GainPoint()
    {
        Player.Instance.health.GainHeart();
        InGameManager.Instance.bonusPoint.GainPoint();
        DataInGame.Instance.score++;
        DataEndGame.Instance.beatingStreak++;
        UpdateBestStreak();
    }

    public void LosePoint()
    {
        Player.Instance.health.currentHeart = 0;
        InGameManager.Instance.lives.UpdateLivesProgress();
        InGameManager.Instance.bonusPoint.LosePoint();
        DataEndGame.Instance.beatingStreak = 0;
    }

    void UpdateBestStreak()
    {
        if (DataEndGame.Instance.beatingStreak >= DataEndGame.Instance.bestStreak)
        {
            DataEndGame.Instance.bestStreak = DataEndGame.Instance.beatingStreak;
        }
    }
}
