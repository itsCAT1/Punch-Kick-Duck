using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class LivesHandler : MonoBehaviour
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

        Color defaultColor;
        ColorUtility.TryParseHtmlString("#7A7A7A", out defaultColor);
        heartUI.color = defaultColor;

        if (currentHeart >= maxHeart)
        {
            Color fullHeartColor;
            ColorUtility.TryParseHtmlString("#D0428D", out fullHeartColor);
            heartUI.color = fullHeartColor;
        }
    }

}
