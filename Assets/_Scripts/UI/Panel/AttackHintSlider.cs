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

    private void OnEnable()
    {
        SetInitPosition();
    }

    void SetInitPosition()
    {
        RectTransform rectTransform = GetComponent<RectTransform>();

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
