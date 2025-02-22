using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DG.Tweening;

public class InGameManager : Singleton<InGameManager>
{
    public ButtonHandler button;
    public LivesHandler lives;
    public BonusPointHandler bonusPoint;

    CanvasGroup canvasGroup;

    void Start()
    {
        canvasGroup = GetComponent<CanvasGroup>();
        UEventDispatcherSingleton.Instance.AddEventListener<RestartGame>(ResetValue);
        UEventDispatcherSingleton.Instance.AddEventListener<MenuGame>(ResetValue);
        UEventDispatcherSingleton.Instance.AddEventListener<StartGame>(ShowUI);
    }

    public void ResetValue(IUEventData uEventData)
    {
        Player.Instance.health.currentHealth = Player.Instance.health.maxHealth;
        Player.Instance.health.currentHeart = Player.Instance.health.maxHeart;
        DataInGame.Instance.beatingPoint = 0;
        DataInGame.Instance.beatingCounter = 0;
        DataInGame.Instance.score = 0;
    }

    public void ShowUI(IUEventData uEventData)
    {
        canvasGroup.alpha = 0;
        canvasGroup.DOFade(1, 1f); 
    }
}
