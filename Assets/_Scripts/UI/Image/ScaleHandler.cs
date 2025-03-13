using DG.Tweening;
using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ScaleHandler : MonoBehaviour
{
    public float scaleStart = 0, scaleEnd = 1.5f;
    public float duration;

    void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<MenuGame>(ResetObject);
        UEventDispatcherSingleton.Instance.AddEventListener<RestartGame>(ResetObject);
    }

    void ResetObject(IUEventData uEventData)
    {
        this.transform.localScale = Vector3.zero;
    }

    [ContextMenu("expand")]
    public void ExpandObject(Vector3 dotScale)
    {
        this.transform.DOScale(scaleEnd, duration);
        DialogueHandler.Instance.dotPos.transform.DOScale(dotScale, duration);
    }

    [ContextMenu("collapse")]
    public void CollapseObject()
    {
        this.transform.DOScale(scaleStart, duration);
        DialogueHandler.Instance.dotPos.transform.DOScale(scaleStart, duration);
    }
}
