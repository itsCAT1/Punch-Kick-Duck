using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEditor.PackageManager;
using UnityEngine;

public class CheckStatusPlayer : MonoBehaviour
{
    EnemyActionHandle enemyAction;
    Animator animator;
    Health health;

    void Start()
    {
        enemyAction = GetComponent<EnemyActionHandle>();
        animator = GetComponent<Animator>();
        health = GetComponent<Health>();

        UEventDispatcherSingleton.Instance.AddEventListener<PlayerHurt>(WaitingPlayer);
        UEventDispatcherSingleton.Instance.AddEventListener<PlayerBlocking>(WaitingPlayer);
        UEventDispatcherSingleton.Instance.AddEventListener<PlayerDeath>(WaitingPlayerDead);
        UEventDispatcherSingleton.Instance.AddEventListener<EndGame>(StopChasing);
    }


    void WaitingPlayer(IUEventData uEventData)
    {
        if(health.currentHealth > 0)
        {
            StartCoroutine(TimeWaiting());
        }
    }


    IEnumerator TimeWaiting()
    {
        enemyAction.DisableAction();
        yield return new WaitForSeconds(2);
        enemyAction.EnableAction();
    }


    void WaitingPlayerDead(IUEventData uEventData)
    {
        if (health.currentHealth > 0)
        {
            enemyAction.DisableAction();
            animator.Play("Win");
        }
    }

    void StopChasing(IUEventData uEventData)
    {
        if (health.currentHealth > 0)
        {
            enemyAction.DisableAction();
        }
    }
}
