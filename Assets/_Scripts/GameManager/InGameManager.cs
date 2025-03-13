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
    public ReviveHandler revive;

    public CanvasGroup canvasGroup;

    public GameObject skipUI;
    public GameObject gameOverUI;
    public bool canRevive;

    void Start()
    {
        canRevive = true;

        UEventDispatcherSingleton.Instance.AddEventListener<RestartGame>(ResetRevive);
        UEventDispatcherSingleton.Instance.AddEventListener<StartGame>(ResetRevive);
        UEventDispatcherSingleton.Instance.AddEventListener<GameOver>(SetRevive);
    }

    private void OnEnable()
    {
        ShowUI();
    }

    void SetRevive(IUEventData uEventData)
    {
        if(DataManager.Instance.data.totalCoin >= 40 && canRevive 
            && DataManager.Instance.data.currentMap != 10)
        {
            canRevive = false;
            skipUI.SetActive(true);
            revive.StartCountTime();
        }
        else gameOverUI.SetActive(true);
    }

    void ResetRevive(IUEventData uEventData)
    {
        canRevive = true;
    }

    public void ShowUI()
    {
        canvasGroup.alpha = 0;
        canvasGroup.DOFade(1, 1);
    }
}
