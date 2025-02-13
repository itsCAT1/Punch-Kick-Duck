using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyReaction : MonoBehaviour
{
    Enemy enemy;

    void Start()
    {
        enemy = GetComponent<Enemy>();

        UEventDispatcherSingleton.Instance.AddEventListener<PlayerDeath>(StopAttack);
        UEventDispatcherSingleton.Instance.AddEventListener<PlayerHurt>(WaitingPlayer);
        UEventDispatcherSingleton.Instance.AddEventListener<PlayerBlocking>(WaitingPlayer);
        UEventDispatcherSingleton.Instance.AddEventListener<EndGame>(StopChasing);
    }

    void WaitingPlayer(IUEventData uEventData)
    {
        Debug.Log("Change");
        enemy.controller.canAttack = false;
        enemy.executer.SetCurrentState("GoBack");
    }


    void StopAttack(IUEventData uEventData)
    {
        enemy.controller.canAttack = false;
        enemy.executer.SetCurrentState("Win");
    }

    void StopChasing(IUEventData uEventData)
    {
        enemy.controller.canAttack = false;
        enemy.executer.SetCurrentState("Idle");
    }
}
