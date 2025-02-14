using DG.Tweening;
using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Threading;

public class EnemyGoingBack : MonoBehaviour
{
    Enemy enemy;

    public float speedMove;

    void Start()
    {
        enemy = GetComponent<Enemy>();
    }

    public void PerformGoingBack()
    {
        StartCoroutine(StartGoingBack());
    }

    IEnumerator StartGoingBack()
    {
        float timeCount = 0;
        float duration = 0.5f;
        float distance = 10;

        if (enemy.controller.haveCart)
        {
            distance = 20;
        }


        while (timeCount <= duration)
        {
            timeCount += Time.deltaTime;
            if (Vector3.Distance(this.transform.position, Player.Instance.transform.position) <= distance)
            {
                float signY = Mathf.Sign(this.transform.rotation.y);

                enemy.rigid.velocity = new Vector3(-signY * speedMove, 0, 0);

                enemy.controller.Standing();
                enemy.animator.Play("GoBack");
            }

            else
            {
                enemy.controller.Standing();
                enemy.animator.Play("Idle");
            }

            yield return null;
        }
    }
}
