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
        UEventDispatcherSingleton.Instance.AddEventListener<LevelTransition>(ResetValue);

        UEventDispatcherSingleton.Instance.AddEventListener<Tutorial>(OnTutorial);
    }

    public void ResetValue(IUEventData uEventData)
    {
        Player.Instance.health.currentHealth = Player.Instance.health.maxHealth;
        Player.Instance.health.SetDataHeart();

        DataInGame.Instance.beatingPoint = 0;
        DataInGame.Instance.beatingCounter = 1;
        DataInGame.Instance.beatingStreak = 0;
        DataInGame.Instance.bestStreak = 0;
        DataInGame.Instance.score = 0;
    }

    void OnTutorial(IUEventData uEventData)
    {
        ShowUI();
    }

    public void ShowUI()
    {
        canvasGroup.alpha = 0;
        canvasGroup.DOFade(1, 1f);
    }
}
