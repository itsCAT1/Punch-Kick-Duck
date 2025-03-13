using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;
using DG.Tweening;

public class AttackHintSlider : SlideHandler
{
    public float startPositionX;
    public float endPositionX;
    public float duration;

    private void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<MenuGame>(SetPosOnStart);
        UEventDispatcherSingleton.Instance.AddEventListener<LevelSelection>(SetPosOnStart);
    }

    private void Awake()
    {
        InitPosition();
    }

    void SetPosOnStart(IUEventData uEventData)
    {
        InitPosition();
    }

    void InitPosition()
    {
        RectTransform rectTransform = GetComponent<RectTransform>();

        int currentMap = DataManager.Instance.data.currentMap;

        if (currentMap % 2 == 1 || currentMap == 10)
        {
            startPositionX = 480;
            endPositionX = -480;
        }
        else
        {
            startPositionX = -2400;
            endPositionX = -1440;
        }

        Vector2 newPosition = rectTransform.anchoredPosition;
        newPosition.x = startPositionX;
        rectTransform.anchoredPosition = newPosition;
    }

    public void OpenHint()
    {
        SlideX(startPositionX, endPositionX, duration);
    }

    public void CloseHint()
    {
        SlideX(endPositionX, startPositionX, duration);
    }
}
