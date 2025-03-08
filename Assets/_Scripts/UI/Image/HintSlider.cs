using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

public class HintSlider : SlideHandler
{
    public float startPositionY;
    public float endPositionY;
    public float duration;

    private void OnEnable()
    {
        SetInitPosition();
    }

    void SetInitPosition()
    {
        RectTransform rectTransform = GetComponent<RectTransform>();

        Vector2 newPosition = rectTransform.anchoredPosition;
        newPosition.y = startPositionY;
        rectTransform.anchoredPosition = newPosition;
    }


    public void OpenHint()
    {
        SlideY(startPositionY, endPositionY, duration);
    }

    public void CloseHint()
    {
        SlideY(endPositionY, startPositionY, duration);
    }
}
