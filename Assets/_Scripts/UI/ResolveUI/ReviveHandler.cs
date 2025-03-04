using RMC.Core.UEvents;
using RMC.Core.UEvents.UEventDispatcher;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ReviveHandler : MonoBehaviour
{
    public GameObject panelRevive;
    public GameObject gameOverUI;
    public Image progressRevive;

    private void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<GameOver>(StartCountTime);
        UEventDispatcherSingleton.Instance.AddEventListener<PlayerRevive>(StartRevive);
        UEventDispatcherSingleton.Instance.AddEventListener<MenuGame>(StartRevive);
        UEventDispatcherSingleton.Instance.AddEventListener<RestartGame>(StartRevive);
    }

    public void Revive()
    {
        InGameManager.Instance.canRevive = false;
        DataManager.Instance.data.totalCoin -= 40;
        InGameManager.Instance.coin.UpdateCoin();

        Player.Instance.executer.SetCurrentState("GetUp");
        panelRevive.SetActive(false);
    }

    public void Skip()
    {
        gameOverUI.SetActive(true);
        panelRevive.SetActive(false);
    }

    public void StartCountTime(IUEventData uEventData)
    {
        StartCoroutine(CountdownTime());
    }

    IEnumerator CountdownTime()
    {
        float timeCount = 0;
        float duration = 2;

        while (timeCount < duration)
        {
            progressRevive.fillAmount = timeCount / duration;
            timeCount += Time.deltaTime;

            yield return null;
        }

        gameOverUI.SetActive(true);
        panelRevive.SetActive(false);
    }

    public void StartRevive(IUEventData uEventData)
    {
        StopAllCoroutines();
    }
}
