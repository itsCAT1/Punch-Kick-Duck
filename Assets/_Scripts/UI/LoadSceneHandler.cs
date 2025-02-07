using RMC.Core.UEvents;
using RMC.Core.UEvents.UEventDispatcher;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LoadSceneHandler : MonoBehaviour
{
    Animator animator;

    void Start()
    {
        animator = GetComponent<Animator>();
        UEventDispatcherSingleton.Instance.AddEventListener<RestartGame>(LoadScene);
    }



    public void LoadScene(IUEventData uEventData)
    {
        animator.Play("LoadScene");
    }
}
