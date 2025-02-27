using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MiniBossReaction : MonoBehaviour
{
    MiniBossActionManager miniBossAction;
    Animator animator;

    void Start()
    {
        miniBossAction = GetComponent<MiniBossActionManager>();
        animator = GetComponent<Animator>();

        UEventDispatcherSingleton.Instance.AddEventListener<PlayerHurt>(WaitingPlayer);
        UEventDispatcherSingleton.Instance.AddEventListener<PlayerBlocking>(WaitingPlayer);
        UEventDispatcherSingleton.Instance.AddEventListener<PlayerDeath>(StopAttack);
        UEventDispatcherSingleton.Instance.AddEventListener<EndGame>(StopChasing);
    }


    void WaitingPlayer(IUEventData uEventData)
    {
        StopAllCoroutines();
        StartCoroutine(TimeWaiting());
    }


    public IEnumerator TimeWaiting()
    {
        miniBossAction.DisableAction();
        yield return new WaitForSeconds(3);
        string statePlayer = Player.Instance.executer.GetCurrentState().Name.ToString();

        if (statePlayer != "Dead")
        {
            miniBossAction.EnableAction();
        }
    }


    void StopAttack(IUEventData uEventData)
    {
        StopAllCoroutines();
        miniBossAction.DisableAction();
        animator.Play("Win");
    }

    void StopChasing(IUEventData uEventData)
    {
        StopAllCoroutines();
        miniBossAction.DisableAction();
    }
}
