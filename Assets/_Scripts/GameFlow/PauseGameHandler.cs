using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class PauseGameHandler : MonoBehaviour
{
    Animator panelPauseAnim;
    public Button buttonPause;

    private void Start()
    {
        panelPauseAnim = GetComponent<Animator>();
    }

    public void PauseGame()
    {
        OpenPanel();
        UEventData uEventData = new UEventData();
        UEventDispatcherSingleton.Instance.Invoke<PauseGame>(uEventData);
    }

    public void OpenPanel()
    {
        Time.timeScale = 0;
        buttonPause.interactable = false;
        panelPauseAnim.Play("Open");
    }

    public void ClosePanel()
    {
        Time.timeScale = 1;
        buttonPause.interactable = true;
        panelPauseAnim.Play("Close");
    }

    public void ContinueGame()
    {
        UEventData uEventData = new UEventData();
        UEventDispatcherSingleton.Instance.Invoke<StartGame>(uEventData);
    }
}
