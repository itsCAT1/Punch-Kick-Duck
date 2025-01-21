using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEditor.PackageManager;
using UnityEngine;

public class CheckStatusPlayer : MonoBehaviour
{
    EnemyActionManager enemyAction;
    Animator animator;

    void Start()
    {
        enemyAction = GetComponent<EnemyActionManager>();
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
        enemyAction.DisableAction();
        yield return new WaitForSeconds(2);
        enemyAction.EnableAction();
    }

    void WaitingPlayerDead(IUEventData uEventData)
    {
        enemyAction.DisableAction();
        animator.Play("Win");
    }
}
