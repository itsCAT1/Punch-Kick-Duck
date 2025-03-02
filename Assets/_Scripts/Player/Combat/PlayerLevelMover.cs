using DG.Tweening;
using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;
using UnityEngine.UIElements;

public class PlayerLevelMover : MonoBehaviour
{
    public Vector3[] targetPos;
    public float duration;

    public Transform[] pos;

    public void PlayerMoving()
    {
        Player.Instance.transform.DOPath(targetPos, duration, PathType.CatmullRom, PathMode.Full3D, 10, Color.red);
        StartCoroutine(StartRotate());
    }

    IEnumerator StartRotate()
    {
        yield return new WaitForSeconds(4);
        Player.Instance.transform.rotation = Quaternion.Euler(0, -Player.Instance.transform.eulerAngles.y, 0);
    }

    [ContextMenu("Create Position")]
    void CreatePosition()
    {
        targetPos = new Vector3[pos.Length];
        for (int i = 0; i < pos.Length; i++)
        {
            targetPos[i] = pos[i].position;
        }
    }

}
