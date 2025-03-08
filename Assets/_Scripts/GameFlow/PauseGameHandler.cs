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

    public void PauseGame()
    {
        AudioManager.Instance.PauseGame();
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
        AudioManager.Instance.ContinueGame();
    }

    public void OpenOptions()
    {
        ConditionManger.Instance.SetState(GameState.Options);
    }
}
