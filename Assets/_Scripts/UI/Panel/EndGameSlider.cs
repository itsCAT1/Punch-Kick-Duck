using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EndGameSlider : SlideHandler
{
    public float startPositionY;
    public float endPositionY;
    public float duration;

    private void OnEnable()
    {
        OpenPanel();
    }

    private void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<LevelTransition>(ClosePanel);
    }

    public void OpenPanel()
    {
        SlideY(startPositionY, endPositionY, duration);
    }

    public void ClosePanel(IUEventData uEventData)
    {
        StartCoroutine(StartClose());
    }

    IEnumerator StartClose()
    {
        SlideY(endPositionY, startPositionY, duration);

        yield return new WaitForSeconds(duration);

        ConditionManger.Instance.endGameUI.SetActive(false);
    }
}
