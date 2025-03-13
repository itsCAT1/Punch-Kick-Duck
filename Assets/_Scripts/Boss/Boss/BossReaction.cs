using RMC.Core.UEvents;
using RMC.Core.UEvents.UEventDispatcher;
using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

public class BossReaction : MonoBehaviour
{
    public AudioSource soundRoar, soundYell, soundHitFloor;

    void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<PlayerDeath>(StopAttack);
        UEventDispatcherSingleton.Instance.AddEventListener<RestartGame>(OnReset);
        UEventDispatcherSingleton.Instance.AddEventListener<MenuGame>(OnReset);
    }

    void StopAttack(IUEventData uEventData)
    {
        if(DataManager.Instance.data.currentMap == 10) Boss.Instance.executer.SetCurrentState("Win");
    }

    void OnReset(IUEventData uEventData)
    {
        if (DataManager.Instance.data.currentMap == 10)
        {
            Boss.Instance.controller.OnReset();
            Boss.Instance.executer.SetCurrentState("Idle");
        }
    }

    public void OnDead()
    {
        CameraManager.Instance.playerCamera.SetActive(false);

        Player.Instance.push.DefeatBoss();
        Player.Instance.executer.SetCurrentState("Win");

        foreach (var fruit in Boss.Instance.throwing.fruitAvatar)
        {
            fruit.SetActive(false);
        }
    }

    public void PlayHitFloor()
    {
        soundHitFloor.Play();
    }
}
