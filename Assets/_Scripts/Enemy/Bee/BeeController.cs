using DG.Tweening;
using FSMC.Runtime;
using RMC.Core.UEvents;
using RMC.Core.UEvents.UEventDispatcher;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BeeController : MonoBehaviour
{
    public BeeAttack attack;
    public BeeMovement movement;
    public BeeBeaten beeBeaten;

    public float targetAngle;
    public float rotationDuration;
    public GameObject currentZone;
    public bool isDead = false;

    FSMC_Executer executer;

    public bool onLeft => transform.position.x < Player.Instance.transform.position.x;

    private void Start()
    {
        executer = GetComponent<FSMC_Executer>();
        UEventDispatcherSingleton.Instance.AddEventListener<PlayerDeath>(PerformLeave);
    }

    void UpdateAngle()
    {
        if (onLeft)
        {
            targetAngle = 0;
        }

        else
        {
            targetAngle = 180;
        }
    }

    public void PerformRotate()
    {
        UpdateAngle();
        transform.DORotate(new Vector3(0, targetAngle, 0), rotationDuration, RotateMode.Fast);
    }

    private void OnTriggerEnter(Collider other)
    {
        if (isDead) return;
        if (Player.Instance.health.currentHealth <= 0) return;

        if (other.gameObject.CompareTag("ZoneChangeDirection") && other.gameObject != currentZone)
        {
            PerformRotate();
            currentZone = other.gameObject;
        }

        if (other.gameObject.CompareTag("Player"))
        {
            Player.Instance.health.TakeDamage();
            executer.SetCurrentState("Fly");
        }

        if (other.gameObject.CompareTag("Punch") || other.gameObject.CompareTag("Kick"))
        {
            isDead = true;
            executer.SetCurrentState("Dead");
        }
    }

    public void PerformLeave(IUEventData uEventData)
    {
        executer.SetCurrentState("Win");
        Destroy(this.gameObject, 2);
    }
}
