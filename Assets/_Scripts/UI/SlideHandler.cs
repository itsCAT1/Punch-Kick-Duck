using DG.Tweening;
using RMC.Core.UEvents;
using RMC.Core.UEvents.UEventDispatcher;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SlideHandler : MonoBehaviour
{
    public float position;
    public float duration;

    private void OnEnable()
    {
        ResetUI();
    }

    public void SlideUI()
    {
        RectTransform rectTransform = GetComponent<RectTransform>();
        rectTransform.DOAnchorPosY(position, duration).SetEase(Ease.InOutQuad);
    }

    public void ResetUI()
    {
        RectTransform rectTransform = GetComponent<RectTransform>();
        rectTransform.anchoredPosition = Vector2.zero;
    }
}
