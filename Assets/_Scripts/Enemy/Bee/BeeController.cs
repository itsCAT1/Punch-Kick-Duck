using DG.Tweening;
using FSMC.Runtime;
using RMC.Core.UEvents;
using RMC.Core.UEvents.UEventDispatcher;
using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

public class BeeController : MonoBehaviour
{
    public float targetAngle;
    public float rotationDuration;
    public GameObject currentZone;
    PushHandler pushHandler;

    public bool canDealDamage;
    public bool isDead = false;

    FSMC_Executer executer;

    public GameObject hitVFXPrefab;
    public Transform hitPosition;

    public bool onLeft => transform.position.x < Player.Instance.transform.position.x;

    private void Start()
    {
        pushHandler = GetComponent<PushHandler>();

        executer = GetComponent<FSMC_Executer>();
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
            if(canDealDamage) DealDamage();
        }

        if (other.gameObject.CompareTag("Punch") || other.gameObject.CompareTag("Kick"))
        {
            canDealDamage = false;
            TakeDamage();
        }
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

    void DealDamage()
    {
        Player.Instance.health.TakeDamage();
        pushHandler.PerformPushPlayer();
        executer.SetCurrentState("Fly");
        CreateHitEffect();
    }

    void TakeDamage()
    {
        isDead = true;
        executer.SetCurrentState("Dead");
        CreateHitEffect();
    }

    public void CreateHitEffect()
    {
        Instantiate(hitVFXPrefab, transform.position, Quaternion.identity);
    }
}
