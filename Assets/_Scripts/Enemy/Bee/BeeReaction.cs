using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BeeReaction : MonoBehaviour
{
    Bee bee;

    void Start()
    {
        bee = GetComponent<Bee>();

        UEventDispatcherSingleton.Instance.AddEventListener<PlayerHurt>(WaitingPlayer);
        UEventDispatcherSingleton.Instance.AddEventListener<PlayerDeath>(PerformLeave);
        UEventDispatcherSingleton.Instance.AddEventListener<EndGame>(PerformLeave);

    }
    string currentState => bee.executer.GetCurrentState().Name.ToString();

    void WaitingPlayer(IUEventData uEventData)
    {
        if (currentState == "Dead") return;

        StartCoroutine(CantDealDamage());
        bee.executer.SetCurrentState("Fly");
    }

    IEnumerator CantDealDamage()
    {
        bee.controller.canDealDamage = false;

        yield return new WaitForSeconds(2);

        bee.controller.canDealDamage = true;
    }

    public void PerformLeave(IUEventData uEventData)
    {
        if (currentState == "Dead") return;

        bee.executer.SetCurrentState("Win");
        Destroy(this.gameObject, 2);
    }
}
