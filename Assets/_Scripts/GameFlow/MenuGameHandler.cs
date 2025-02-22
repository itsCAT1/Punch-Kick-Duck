using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DG.Tweening;

public class MenuGameHandler : MonoBehaviour
{
    

    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    public void StartGame()
    {
        UEventData uEventData = new UEventData();
        UEventDispatcherSingleton.Instance.Invoke<StartGame>(uEventData);

        SlideDownMenu();
    }

    void SlideDownMenu()
    {
        RectTransform rectTransform = GetComponent<RectTransform>();
        rectTransform.DOAnchorPosY(-600, 0.5f).SetEase(Ease.InOutQuad);
    }
}
