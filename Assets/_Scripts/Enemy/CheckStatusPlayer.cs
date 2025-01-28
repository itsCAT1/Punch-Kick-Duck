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

        UEventDispatcherSingleton.Instance.AddEventListener<PlayerHurt>(WaitingPlayer);
        UEventDispatcherSingleton.Instance.AddEventListener<PlayerBlocking>(WaitingPlayer);
        UEventDispatcherSingleton.Instance.AddEventListener<PlayerDeath>(WaitingPlayerDead);
    }


    void WaitingPlayer(IUEventData uEventData)
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
