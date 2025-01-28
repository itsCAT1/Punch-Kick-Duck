using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class LivesHandle : MonoBehaviour
{
    public Text valueLives;

    public Image heartUI;
    public Image progressLivesUI;


    private void Update()
    {
        UpdateLivesProgress();
    }

    public void UpdateLivesProgress()
    {
        valueLives.text = Player.Instance.health.currentHeart.ToString();

        int currentHeart = Player.Instance.health.currentHeart;
        int maxHeart = Player.Instance.health.maxHeart;

        progressLivesUI.fillAmount = (float)currentHeart / (float)maxHeart;

        heartUI.color = Color.black;

        if (currentHeart >= maxHeart)
        {
            heartUI.color = Color.white;
        }
    }

}
