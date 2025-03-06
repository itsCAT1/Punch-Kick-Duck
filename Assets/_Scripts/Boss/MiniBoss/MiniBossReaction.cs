using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MiniBossReaction : MonoBehaviour
{
    void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<PlayerHurt>(WaitingPlayer);
        UEventDispatcherSingleton.Instance.AddEventListener<PlayerBlocking>(WaitingPlayer);
        UEventDispatcherSingleton.Instance.AddEventListener<PlayerDeath>(PerformDance);
        UEventDispatcherSingleton.Instance.AddEventListener<EndGame>(StopChasing);
        UEventDispatcherSingleton.Instance.AddEventListener<PlayerRevive>(ContinuesAttack);
    }


    void WaitingPlayer(IUEventData uEventData)
    {
        StopAllCoroutines();
        StartCoroutine(StartWaitingCoroutine());
    }


    public IEnumerator StartWaitingCoroutine()
    {
        MiniBoss.Instance.controller.canAttack = false;
        MiniBoss.Instance.executer.SetCurrentState("Idle");

        yield return new WaitForSeconds(3);

        string statePlayer = Player.Instance.executer.GetCurrentState().Name.ToString();
        if (statePlayer != "Dead")
        {
            MiniBoss.Instance.controller.canAttack = true;
        }
    }


    void PerformDance(IUEventData uEventData)
    {
        StopAllCoroutines();

        Debug.Log("win");
        MiniBoss.Instance.controller.canAttack = false;
        MiniBoss.Instance.executer.SetCurrentState("Win");
    }

    void StopChasing(IUEventData uEventData)
    {
        StopAllCoroutines();
        MiniBoss.Instance.controller.canAttack = false;
        MiniBoss.Instance.executer.SetCurrentState("Idle");
    }

    void ContinuesAttack(IUEventData uEventData)
    {
        StopAllCoroutines();
        MiniBoss.Instance.controller.canAttack = true;
    }
}
