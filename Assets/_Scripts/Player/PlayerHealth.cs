using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerHealth : Health
{
    public int currentHeart;
    public int maxHeart;

    private void Start()
    {
        currentHealth = maxHealth;
        GetDataHeart();
    }

    void GetDataHeart()
    {
        var dataPlayer = Player.Instance.controller.GetDataPlayer(DataBase.Instance.currentMap);
        maxHeart = dataPlayer.maxHeart;
        currentHeart = maxHeart;
    }

    protected override void Hurt()
    {
        Player.Instance.controller.executer.SetCurrentState("Hurt");
        currentHeart = 0;
        StartCoroutine(PlayerIsHurt());
    }

    IEnumerator PlayerIsHurt()
    {
        isHurt = true;
        yield return new WaitForSeconds(0.6f);
        isHurt = false;
    }

    protected override void Dead()
    {
        Player.Instance.controller.executer.SetCurrentState("Dead");
    }

    public void GainHeart()
    {
        if (currentHeart >= maxHeart)
        {
            return;
        }

        currentHeart++;
        InGameUIManager.Instance.lives.UpdateLivesProgress();

        if (currentHeart >= maxHeart)
        {
            currentHealth = 2;
        }
    }
}
