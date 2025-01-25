using DG.Tweening;
using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyGoingBack : ObjectMoving
{
    Animator animator;

    void Start()
    {
        animator = GetComponent<Animator>();
        UEventDispatcherSingleton.Instance.AddEventListener<StatusPlayerHurt>(PerformBack);
    }

    public void PerformBack(IUEventData uEventData)
    {
        StartCoroutine(StartGoingBack());
    }

    IEnumerator StartGoingBack()
    {
        yield return new WaitForSeconds(0.5f);

        if (Vector3.Distance(this.transform.position, Player.Instance.transform.position) <= 2)
        {
            float signY = Mathf.Sign(this.transform.rotation.y);
            var targetPos = Player.Instance.transform.position.x - signY * pushForce;
            PerformMoving(targetPos);

            animator.Play("GoBack");
        }
    }
}
