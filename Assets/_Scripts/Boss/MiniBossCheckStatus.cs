using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MiniBossCheckStatus : MonoBehaviour
{
    MiniBossActionManager miniBossAction;
    Animator animator;

    void Start()
    {
        miniBossAction = GetComponent<MiniBossActionManager>();
        animator = GetComponent<Animator>();

        UEventDispatcherSingleton.Instance.AddEventListener<StatusPlayerHurt>(WaitingPlayerHurt);
        UEventDispatcherSingleton.Instance.AddEventListener<StatusPlayerDead>(WaitingPlayerDead);
    }


    void WaitingPlayerHurt(IUEventData uEventData)
    {
        StartCoroutine(TimeWaiting());
    }


    IEnumerator TimeWaiting()
    {
        miniBossAction.DisableAction();
        yield return new WaitForSeconds(2);
        miniBossAction.EnableAction();
    }

    void WaitingPlayerDead(IUEventData uEventData)
    {
        miniBossAction.DisableAction();
        animator.Play("Win");
    }
}
