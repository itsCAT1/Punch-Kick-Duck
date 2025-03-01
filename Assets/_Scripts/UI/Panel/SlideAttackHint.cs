using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;
using DG.Tweening;

public class SlideAttackHint : SlideHandler
{
    public float startPositionX;
    public float endPositionX;
    public float duration;


    public void OpenHint()
    {
        SlideX(startPositionX, endPositionX, duration);
    }

    public void CloseHint()
    {
        SlideX(endPositionX, startPositionX, duration);
    }
}
