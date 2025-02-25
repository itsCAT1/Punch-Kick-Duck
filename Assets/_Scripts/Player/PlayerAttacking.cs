using RMC.Core.UEvents;
using RMC.Core.UEvents.UEventDispatcher;
using System.Collections;
using System.Collections.Generic;
using Unity.IO.LowLevel.Unsafe;
using UnityEngine;

public class PlayerAttacking : MonoBehaviour
{
    float startTime = 0;
    public float interval = 0.3f;
    public bool timeCoolDown => Time.time - startTime >= interval;

    public bool punchLeft = false;

    public bool canAttack;

    private void Update()
    {
        if (Input.GetKeyDown(KeyCode.Q))
        {
            PerformPunch();
            Player.Instance.controller.ChangeDirection(-1);
        }
        if (Input.GetKeyDown(KeyCode.A))
        {
            PerformKick();
            Player.Instance.controller.ChangeDirection(-1);
        }
        if (Input.GetKeyDown(KeyCode.Z))
        {
            PerformDuck();
            Player.Instance.controller.ChangeDirection(-1);
        }

        if (Input.GetKeyDown(KeyCode.O))
        {
            PerformPunch();
            Player.Instance.controller.ChangeDirection(1);
        }
        if (Input.GetKeyDown(KeyCode.K))
        {
            PerformKick();
            Player.Instance.controller.ChangeDirection(1);
        }
        if (Input.GetKeyDown(KeyCode.M))
        {
            PerformDuck();
            Player.Instance.controller.ChangeDirection(1);
        }
    }

    void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<PlayerHurt>(DisableAttackTemporary);
        UEventDispatcherSingleton.Instance.AddEventListener<PlayerBlocking>(DisableAttackTemporary);
        UEventDispatcherSingleton.Instance.AddEventListener<PlayerBlocking>(DisableAttack);

        UEventDispatcherSingleton.Instance.AddEventListener<MenuGame>(EnableAttack);
        UEventDispatcherSingleton.Instance.AddEventListener<StartGame>(EnableAttack);
        UEventDispatcherSingleton.Instance.AddEventListener<InGame>(EnableAttack);
    }

    public void PerformPunch()
    {
        if (timeCoolDown && canAttack)
        {
            startTime = Time.time;
            Player.Instance.executer.SetTrigger("Punch");
        }
    }

    public void PerformKick()
    {
        if (timeCoolDown && canAttack)
        {
            startTime = Time.time;
            Player.Instance.executer.SetTrigger("Kick");
        }
    }

    public void PerformDuck()
    {
        if (timeCoolDown && canAttack)
        {
            startTime = Time.time;
            Player.Instance.executer.SetTrigger("Duck");
        }
    }

    void EnableAttack(IUEventData uEventData)
    {
        canAttack = true;
    }

    void DisableAttack(IUEventData uEventData)
    {
        canAttack = false;
    }

    void DisableAttackTemporary(IUEventData uEventData)
    {
        canAttack = false;

        CancelInvoke(nameof(Enable));
        Invoke(nameof(Enable), 1f);
    }

    void Enable()
    {
        canAttack = true;
    }
}
