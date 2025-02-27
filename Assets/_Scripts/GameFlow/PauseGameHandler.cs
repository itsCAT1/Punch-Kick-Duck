using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class PauseGameHandler : MonoBehaviour
{
    public Animator animator;
    public Button buttonPause;
    public GameObject panelPause;

    public void PauseGame()
    {
        UEventData uEventData = new UEventData();
        UEventDispatcherSingleton.Instance.Invoke<PauseGame>(uEventData);

        OpenPanel();
    }

    public void OpenPanel()
    {
        Time.timeScale = 0;
        buttonPause.interactable = false;
        animator.Play("Open");
    }

    public void ClosePanel()
    {
        Time.timeScale = 1;
        buttonPause.interactable = true;
        animator.Play("Close");
    }

    public void ContinueGame()
    {
        Time.timeScale = 1;

        UEventData uEventData = new UEventData();

        if (ConditionManger.Instance.currentState == GameState.InGame)
        {
            UEventDispatcherSingleton.Instance.Invoke<InGame>(uEventData);
        }

        if (ConditionManger.Instance.currentState == GameState.StartGame)
        {
            UEventDispatcherSingleton.Instance.Invoke<StartGame>(uEventData);
        }

        ConditionManger.Instance.attackUI.SetActive(true);


    }
}
