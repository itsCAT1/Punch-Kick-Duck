using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class MiniBossHandler : MonoBehaviour
{
    public Text timeCount;
    public Image progressTimeUI;
    public Image iconBear;


    private void Update()
    {
        UpdateLives();
    }

    public void UpdateLives()
    {
        timeCount.text = SpawningMiniBoss.Instance.timeCounter.ToString();

        float currentTime = SpawningMiniBoss.Instance.timeCounter;

        var dataPlayer = Player.Instance.controller.GetDataPlayer(DataManager.Instance.data.currentMap);
        float maxTime = dataPlayer.timeSpawnBoss;

        progressTimeUI.fillAmount = currentTime / maxTime;

        iconBear.color = Color.black;
        timeCount.enabled = true;

        if (currentTime <= 0)
        {
            timeCount.enabled = false;
            iconBear.color = Color.white;
        }
    }
}
