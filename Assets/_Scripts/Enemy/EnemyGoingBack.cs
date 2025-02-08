using DG.Tweening;
using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyGoingBack : ObjectMoving
{
    Animator animator;
    Rigidbody rigid;
    Health health;

    void Start()
    {
        animator = GetComponent<Animator>();
        rigid = GetComponent<Rigidbody>();
        health = GetComponent<Health>();

        UEventDispatcherSingleton.Instance.AddEventListener<PlayerHurt>(PerformBack);
        UEventDispatcherSingleton.Instance.AddEventListener<PlayerBlocking>(PerformBack);
    }


    public void PerformBack(IUEventData uEventData)
    {
        if (health.currentHealth > 0)
        {
            StartCoroutine(StartGoingBack());
        }
    }

    IEnumerator StartGoingBack()
    {
        float timeCount = 0;
        float duration = 0.5f;
            
        while (timeCount <= duration)
        {
            timeCount += Time.deltaTime;
            if (Vector3.Distance(this.transform.position, Player.Instance.transform.position) <= 10)
            {
                float signY = Mathf.Sign(this.transform.rotation.y);

                rigid.isKinematic = false;
                rigid.velocity = new Vector3(-signY * pushForce, 0, 0);

                animator.Play("GoBack");
            }

            else
            {
                animator.Play("Idle");
            }

            yield return null;
        }
    }
}
