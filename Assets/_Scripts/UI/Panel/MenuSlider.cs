using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MenuSlider : SlideHandler
{
    public Vector2 startPos;
    public Vector2 endPos;

    public float duration;

    private void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<MenuGame>(OnMenu);
    }

    public void Slide()
    {
        SlideUI(startPos, endPos, duration);
    }

    void OnMenu(IUEventData uEventData)
    {
        RectTransform menuPos = this.GetComponent<RectTransform>();
        menuPos.anchoredPosition = Vector2.zero;
    }
}
