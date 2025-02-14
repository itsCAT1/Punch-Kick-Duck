using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class OpeningDoor : MonoBehaviour
{
    Animator animator;

    void Start()
    {
        animator = GetComponent<Animator>();
        UEventDispatcherSingleton.Instance.AddEventListener<RestartGame>(Close);
        UEventDispatcherSingleton.Instance.AddEventListener<LevelTransition>(Close);
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.CompareTag("Enemy"))
        {
            Open();
        }

        if (other.gameObject.CompareTag("Punch") || other.gameObject.CompareTag("Kick") || other.gameObject.CompareTag("Duck"))
        {
            Open();
            GetComponent<Collider>().enabled = false;
        }
    }

    void Open()
    {
        animator.Play("OpenDoor");
    }

    void Close(IUEventData uEventData)
    {
        animator.Play("CloseDoor");
        GetComponent<Collider>().enabled = true;
    }
}
