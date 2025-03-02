using DG.Tweening;
using RMC.Core.UEvents;
using RMC.Core.UEvents.UEventDispatcher;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SlideHandler : MonoBehaviour
{

    public void SlideUI(Vector2 startPosition, Vector2 endPosition, float duration)
    {
        RectTransform rectTransform = GetComponent<RectTransform>();

        rectTransform.anchoredPosition = startPosition;
        rectTransform.DOAnchorPos(endPosition, duration).SetEase(Ease.InOutQuad);
    }

    public void SlideX(float startPosition, float endPosition, float duration)
    {
        RectTransform rectTransform = GetComponent<RectTransform>();

        Vector2 newPosition = rectTransform.anchoredPosition;
        newPosition.x = startPosition;
        rectTransform.anchoredPosition = newPosition;

        rectTransform.DOAnchorPosX(endPosition, duration).SetEase(Ease.InOutQuad);
    }

    public void SlideY(float startPosition, float endPosition, float duration)
    {
        RectTransform rectTransform = GetComponent<RectTransform>();

        Vector2 newPosition = rectTransform.anchoredPosition;
        newPosition.y = startPosition;
        rectTransform.anchoredPosition = newPosition;

        rectTransform.DOAnchorPosY(endPosition, duration).SetEase(Ease.InOutQuad);
    }
}
