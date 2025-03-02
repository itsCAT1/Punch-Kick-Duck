using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DG.Tweening;

public class InGameManager : Singleton<InGameManager>
{
    public LivesHandler lives;
    public BonusPointHandler bonusPoint;
    public ScoreHandler score;
    public CoinHandler coin;
    public MiniBossHandler miniBoss;

    public CanvasGroup canvasGroup;

    void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<RestartGame>(ResetValue);
        UEventDispatcherSingleton.Instance.AddEventListener<MenuGame>(ResetValue);
    }

    public void ResetValue(IUEventData uEventData)
    {
        DataInGame.Instance.beatingPoint = 0;
        DataInGame.Instance.beatingCounter = 1;
        DataInGame.Instance.beatingStreak = 0;
        DataInGame.Instance.bestStreak = 0;
        DataInGame.Instance.score = 0;
    }

    public void ShowUI()
    {
        canvasGroup.alpha = 0;
        canvasGroup.DOFade(1, 1);
    }
}
