using RMC.Core.UEvents;
using RMC.Core.UEvents.UEventDispatcher;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LoadSceneHandler : Singleton<LoadSceneHandler>
{
    Animator animator;

    void Start()
    {
        animator = GetComponent<Animator>();
    }


    [ContextMenu ("load")]
    public void LoadScene()
    {
        animator.Play("LoadScene");
    }

    IEnumerator StartLoad()
    {
        yield return new WaitForSeconds(0.2f);
        animator.Play("LoadScene");
    }
}
