using DG.Tweening;
using RMC.Core.UEvents;
using RMC.Core.UEvents.UEventDispatcher;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class MiniBossHandler : MonoBehaviour
{
    public Text timeCount;
    public Image progressTimeUI;
    public Image iconBear;

    public GameObject warningLeft;
    public GameObject warningRight;

    public CanvasGroup canvasGroup;

    private void Start()
    {
        UpdateTimer();

        UEventDispatcherSingleton.Instance.AddEventListener<EndGame>(CloseWarning);
        UEventDispatcherSingleton.Instance.AddEventListener<MenuGame>(CloseWarning);
        UEventDispatcherSingleton.Instance.AddEventListener<RestartGame>(CloseWarning);
    }

    public void UpdateTimer()
    {
        float currentTime = SpawningMiniBoss.Instance.timeCounter;

        timeCount.text = currentTime.ToString();

        var dataPlayer = Player.Instance.controller.GetDataPlayer(DataManager.Instance.data.currentMap);
        float maxTime = dataPlayer.timeSpawnBoss;

        progressTimeUI.fillAmount = currentTime / maxTime;

        iconBear.color = Color.black;
        timeCount.enabled = true;

        if (currentTime <= 0)
        {
            timeCount.enabled = false;
            iconBear.color = Color.white;
            StopAllCoroutines();
            StartCoroutine(OnWarning(dataPlayer));
        }
    }

    IEnumerator OnWarning(DataPlayer dataPlayer)
    {
        Debug.Log("warning");
        if(dataPlayer.playerDirection < 0) warningRight.SetActive(true);
        else warningLeft.SetActive(true);

        yield return new WaitForSeconds(2);

        FadeUI();

        yield return new WaitForSeconds(1);

        warningLeft.SetActive(false);
        warningRight.SetActive(false);
    }

    public void FadeUI()
    {
        canvasGroup.alpha = 1;
        canvasGroup.DOFade(0, 1f);
    }

    void CloseWarning(IUEventData uEventData)
    {
        warningLeft.SetActive(false);
        warningRight.SetActive(false);
    }
}
