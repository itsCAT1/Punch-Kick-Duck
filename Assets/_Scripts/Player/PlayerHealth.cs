using RMC.Core.UEvents;
using RMC.Core.UEvents.UEventDispatcher;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerHealth : Health
{
    public int currentHeart;
    public int maxHeart;

    private void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<PlayerBlocking>(LoseHeart);

        currentHealth = maxHealth;
        GetDataHeart();
    }

    void GetDataHeart()
    {
        var dataPlayer = Player.Instance.controller.GetDataPlayer(DataManager.Instance.data.currentMap);
        maxHeart = dataPlayer.maxHeart;
        currentHeart = maxHeart;
    }

    protected override void Hurt()
    {
        Player.Instance.executer.SetCurrentState("Hurt");
        currentHeart = 0;
    }

    protected override void Dead()
    {
        Player.Instance.executer.SetCurrentState("Dead");
    }

    public void GainHeart()
    {
        if (currentHeart >= maxHeart)
        {
            return;
        }

        currentHeart++;
        InGameManager.Instance.lives.UpdateLivesProgress();

        if (currentHeart >= maxHeart)
        {
            currentHealth = 2;
        }
    }


    void LoseHeart(IUEventData uEventData)
    {
        if (Player.Instance.health.currentHealth == 1)
        {
            Player.Instance.health.currentHeart = 0;
        }

        InGameManager.Instance.lives.UpdateLivesProgress();
    }
}
