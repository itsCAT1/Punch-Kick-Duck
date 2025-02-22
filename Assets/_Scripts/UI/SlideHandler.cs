using DG.Tweening;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SlideHandler : MonoBehaviour
{
    public float position;
    public float duration;

    public void SlideUI()
    {
        RectTransform rectTransform = GetComponent<RectTransform>();
        rectTransform.DOAnchorPosY(position, duration).SetEase(Ease.InOutQuad);
    }
}
