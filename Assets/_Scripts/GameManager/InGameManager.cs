using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class InGameManager : Singleton<InGameManager>
{
    public ButtonHandler button;
    public LivesHandler lives;
    public BonusPointHandler bonusPoint;
    public PauseGameHandler pauseGame;

    void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<RestartGame>(ResetValue);
    }

    public void ResetValue(IUEventData uEventData)
    {
        Player.Instance.health.currentHealth = Player.Instance.health.maxHealth;
        Player.Instance.health.currentHeart = Player.Instance.health.maxHeart;
        DataInGame.Instance.beatingPoint = 0;
        DataInGame.Instance.beatingCounter = 0;
        DataInGame.Instance.score = 0;
    }
}
