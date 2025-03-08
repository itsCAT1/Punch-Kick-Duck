using RMC.Core.UEvents;
using RMC.Core.UEvents.UEventDispatcher;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class LivesHandler : MonoBehaviour
{
    public Image heartUI;
    public Image progressLivesUI;

    private void Start()
    {
        ShowLives();

        UEventDispatcherSingleton.Instance.AddEventListener<InGame>(UpdateLives);
        UEventDispatcherSingleton.Instance.AddEventListener<StartGame>(UpdateLives);
    }

    public void ShowLives()
    {
        int currentHeart = Player.Instance.health.currentHeart;
        int maxHeart = Player.Instance.health.maxHeart;

        progressLivesUI.fillAmount = (float)currentHeart / (float)maxHeart;

        heartUI.color = new Color32(122, 122, 122, 255);

        if (currentHeart >= maxHeart)
        {
            heartUI.color = new Color32(208, 67, 141, 255);
        }
    }

    void UpdateLives(IUEventData uEventData)
    {
        ShowLives();
    }
}
