using DG.Tweening;
using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class NextLevelHandler : MonoBehaviour
{
    public Vector3[] targetPos;
    public float duration;

    private void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<EndGame>(PlayerMoving);
    }

    void PlayerMoving(IUEventData uEventData)
    {
        this.transform.DOPath(targetPos, duration, PathType.CatmullRom, PathMode.Full3D, 10, Color.red);
        StartCoroutine(StartRotate());
    }

    IEnumerator StartRotate()
    {
        yield return new WaitForSeconds(5);
        this.transform.rotation = Quaternion.Euler(0, -this.transform.eulerAngles.y, 0);
    }
}
