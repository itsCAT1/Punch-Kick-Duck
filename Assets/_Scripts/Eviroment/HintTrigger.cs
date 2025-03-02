using Lean.Common;
using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HintTrigger : MonoBehaviour
{
    public bool canShow;
    public HintSlider attackHint;


    void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<Tutorial>(EnableSpawn);
    }

    private void OnEnable()
    {
        canShow = true;
    }

    void EnableSpawn(IUEventData uEventData)
    {
        canShow = true;
    }


    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.CompareTag("Player") && canShow)
        {
            canShow = false;
            attackHint.OpenHint();
        }
    }
}
