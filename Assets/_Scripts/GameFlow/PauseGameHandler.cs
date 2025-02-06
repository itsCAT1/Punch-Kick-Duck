using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class PauseGameHandler : MonoBehaviour
{
    Animator panelPauseAnim;

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
        panelPauseAnim.Play("Open");
    }

    public void ClosePanel()
    {
        Time.timeScale = 1;
        panelPauseAnim.Play("Close");
    }
}
