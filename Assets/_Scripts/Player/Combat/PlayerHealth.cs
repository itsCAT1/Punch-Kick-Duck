using RMC.Core.UEvents;
using RMC.Core.UEvents.UEventDispatcher;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerHealth : Health
{
    public int currentHeart;
    public int maxHeart;

    private void Update()
    {
        if (Input.GetKeyDown(KeyCode.Space))
        {
            TakeDamage();
        }
    }

    private void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<PlayerBlocking>(LoseHeart);
        UEventDispatcherSingleton.Instance.AddEventListener<Tutorial>(SetDataTutorial);
        UEventDispatcherSingleton.Instance.AddEventListener<InGame>(SetDataInGame);
    }

    public void SetDataTutorial(IUEventData uEventData)
    {
        Player.Instance.health.currentHealth = 1000;

        var dataPlayer = Player.Instance.controller.GetDataPlayer(DataManager.Instance.data.currentMap);
        maxHeart = dataPlayer.maxHeart;
        currentHeart = maxHeart;
    }

    public void SetDataInGame(IUEventData uEventData)
    {
        Player.Instance.health.currentHealth = Player.Instance.health.maxHealth;
        var dataPlayer = Player.Instance.controller.GetDataPlayer(DataManager.Instance.data.currentMap);
        maxHeart = dataPlayer.maxHeart;
        currentHeart = maxHeart;
    }

    protected override void Hurt()
    {
        Player.Instance.executer.SetCurrentState("Hurt");
    }

    protected override void Dead()
    {
        Player.Instance.executer.SetCurrentState("Dead");
    }

    public void GainHeart()
    {
        if (ConditionManger.Instance.currentState == GameState.Tutorial) return;

        if (currentHeart == maxHeart)
        {
            return;
        }

        currentHeart++;

        InGameManager.Instance.lives.ShowLives();

        if (currentHeart >= maxHeart)
        {
            currentHealth = 2;
            AudioManager.Instance.heartReached.Play();
        }
    }

    void LoseHeart(IUEventData uEventData)
    {
        if (ConditionManger.Instance.currentState == GameState.Tutorial) return;

        Player.Instance.health.currentHeart = 0;

        InGameManager.Instance.lives.ShowLives();
    }
}
