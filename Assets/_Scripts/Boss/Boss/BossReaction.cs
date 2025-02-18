using RMC.Core.UEvents;
using RMC.Core.UEvents.UEventDispatcher;
using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

public class BossReaction : MonoBehaviour
{

    void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<PlayerDeath>(StopAttack);
    }

    void StopAttack(IUEventData uEventData)
    {
        Boss.Instance.executer.SetCurrentState("Win");
    }
}
