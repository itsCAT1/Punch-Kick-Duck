using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DoorHandler : MonoBehaviour
{
    Animator animator;

    void Start()
    {
        animator = GetComponent<Animator>();
        UEventDispatcherSingleton.Instance.AddEventListener<RestartGame>(Close);
        UEventDispatcherSingleton.Instance.AddEventListener<MenuGame>(Close);
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
            DataInGame.Instance.inRoom = true;

            if (DataManager.Instance.data.currentMap == 10)
            {
                CameraManager.Instance.GoBossArea();
                StartCoroutine(EnterBoss());
            }
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

    IEnumerator EnterBoss()
    {
        yield return new WaitForSeconds(5);
        GetComponent<Collider>().enabled = false;
    }
}
