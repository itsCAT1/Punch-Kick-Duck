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

    private void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<MenuGame>(ResetUI);
    }

    public void SlideUI()
    {
        RectTransform rectTransform = GetComponent<RectTransform>();
        rectTransform.DOAnchorPosY(position, duration).SetEase(Ease.InOutQuad);
    }

    public void ResetUI(IUEventData uEventData)
    {
        StartCoroutine(StartReset());
    }

    IEnumerator StartReset()
    {
        yield return new WaitForSeconds(0.1f);
        RectTransform rectTransform = GetComponent<RectTransform>();
        rectTransform.anchoredPosition = Vector2.zero;
    }
}
