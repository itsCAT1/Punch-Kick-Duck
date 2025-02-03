using DG.Tweening;
using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class test : MonoBehaviour
{
    public Vector3[] targetPos;
    public Transform[] pos;

    [ContextMenu("Create Position")]
    void Convert()
    {
        for(int i = 0; i < pos.Length; i++)
        {
            targetPos[i] = pos[i].position;
        }
    }

}
