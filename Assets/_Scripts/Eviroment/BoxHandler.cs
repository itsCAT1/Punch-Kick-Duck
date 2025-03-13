using DG.Tweening;
using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;
using Unity.VisualScripting;
using System;
using System.Reflection;

public class BoxHandler : MonoBehaviour
{
    Animator animator;
    public float duration;
    public GameObject skinPrefab;
    public AudioSource audioJumpingOut;

    void Start()
    {
        animator = GetComponent<Animator>();
        UEventDispatcherSingleton.Instance.AddEventListener<MenuGame>(ResetPosition);
    }


    public void PlayUnbox()
    {
        animator.Play("Unbox");
    }

    public void CreateSkin()
    {
        var skinTemp = Instantiate(skinPrefab, this.transform.position, Quaternion.Euler(new Vector3(0, 90, 0)));
        CharacterSelectionHandler.Instance.skinOwned.Add(skinTemp);
        audioJumpingOut.Play();
    }

    public void MoveFoward()
    {
        this.transform.DOMoveZ(-3, duration);
    }

    public void MoveBack()
    {
        this.transform.DOMoveZ(1, duration);
    }

    public void ResetPosition(IUEventData uEventData)
    {
        this.transform.position = new Vector3(transform.position.x, transform.position.y, 1);
    }
}
