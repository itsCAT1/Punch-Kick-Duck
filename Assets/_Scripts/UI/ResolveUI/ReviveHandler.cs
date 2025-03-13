using DG.Tweening;
using RMC.Core.UEvents;
using RMC.Core.UEvents.UEventDispatcher;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ReviveHandler : MonoBehaviour
{
    public GameObject gameOverUI;
    public GameObject skipUI;
    public Image progressRevive;
    public AudioSource audioRevive;

    Coroutine countTimeCoroutine;

    private void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<MenuGame>(InitRevive);
        UEventDispatcherSingleton.Instance.AddEventListener<RestartGame>(InitRevive);
    }

    public void Revive()
    {
        InGameManager.Instance.canRevive = false;
        DataManager.Instance.data.totalCoin -= 40;
        InGameManager.Instance.coin.UpdateCoin();

        Player.Instance.executer.SetCurrentState("GetUp");
        
        StopAllCoroutines();
        HideRevive();
        skipUI.SetActive(false);
    }

    public void Skip()
    {
        StopAllCoroutines();
        
        HideRevive();
        gameOverUI.SetActive(true);
        skipUI.SetActive(false);
    }

    public void StartCountTime()
    {
        StartCoroutine(CountdownTime());
    }

    IEnumerator CountdownTime()
    {
        float timeCount = 0;
        float duration = 3;
        ShowRevive();

        while (timeCount < duration)
        {
            progressRevive.fillAmount = timeCount / duration;
            timeCount += Time.deltaTime;

            yield return null;
        }

        HideRevive();
        gameOverUI.SetActive(true);
        skipUI.SetActive(false);
    }

    void InitRevive(IUEventData uEventData)
    {
        this.transform.localScale = Vector3.zero;
        skipUI.SetActive(false);
    }

    public void ShowRevive()
    {
        this.transform.DOScale(1, 0.3f);
        audioRevive.Play();
    }

    public void HideRevive()
    {
        this.transform.DOScale(0, 0.3f);
    }
}
