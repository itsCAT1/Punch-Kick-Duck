using DG.Tweening;
using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;
using UnityEngine.UIElements;

public class PlayerLevelMover : WaypointController
{
    public float duration;

    public void PlayerMoving()
    {
        StartCoroutine(StartMove());

        if(DataManager.Instance.data.currentMap < 9) StartCoroutine(StartRotate());
    }

    IEnumerator StartMove()
    {
        float timeCount = 0;
        Player.Instance.rigid.useGravity = false;
        Player.Instance.GetComponent<Collider>().enabled = false;

        while (timeCount < duration)
        {
            PlayerPerformMoving();

            timeCount += Time.deltaTime;
            yield return null;
        }

        Player.Instance.rigid.useGravity = true;
        Player.Instance.GetComponent<Collider>().enabled = true;

        Player.Instance.transform.position = new Vector3(Player.Instance.transform.position.x, Player.Instance.transform.position.y, 0);
    }

    IEnumerator StartRotate()
    {
        yield return new WaitForSeconds(7);
        Player.Instance.transform.rotation = Quaternion.Euler(0, -Player.Instance.transform.eulerAngles.y, 0);
    }

}
