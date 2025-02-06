using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyReaction : MonoBehaviour
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
        UEventDispatcherSingleton.Instance.AddEventListener<PlayerDeath>(StopAttack);
        UEventDispatcherSingleton.Instance.AddEventListener<EndGame>(StopChasing);
    }

    void WaitingPlayer(IUEventData uEventData)
    {
        if (health.currentHealth > 0)
        {
            Debug.Log("wait");
            StartCoroutine(TimeWaiting());
        }
    }


    public IEnumerator TimeWaiting()
    {
        enemyAction.DisableAction();
        yield return new WaitForSeconds(2);
        if (health.currentHealth > 0)
        {
            enemyAction.EnableAction();
        }
        
    }


    void StopAttack(IUEventData uEventData)
    {
        if (health.currentHealth > 0)
        {
            Debug.Log("stop");
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
