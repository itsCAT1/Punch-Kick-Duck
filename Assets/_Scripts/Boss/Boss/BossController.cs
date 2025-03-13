using DG.Tweening;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BossController : MonoBehaviour
{
    public bool isUpdate = true;
    public int attackCount = 2;
    public int throwCount = 0;

    public float distanceAttack, distanceThrow;

    public bool isAttacking = true;
    public bool isThrowing = false;
    public bool isPounching = false;

    private void Update()
    {
        UpdateAction();
    }

    public void UpdateAction()
    {
        if (!isUpdate || Boss.Instance.executer.GetCurrentState() == null) return;

        SetAction();
    }

    public void SetAction()
    {
        float distance = Vector3.Distance(Player.Instance.transform.position, Boss.Instance.transform.position);

        if (isAttacking)
        {
            if (distance >= distanceAttack + 0.2f)
            {
                Boss.Instance.executer.SetCurrentState("Idle");
            }

            else if (distance <= distanceAttack - 0.2f)
            {
                Boss.Instance.executer.SetCurrentState("Attack");
            }
        }

        if (isThrowing)
        {
            if (distance >= distanceThrow + 0.2f)
            {
                Boss.Instance.executer.SetCurrentState("Idle");
            }

            else if (distance <= distanceThrow - 0.2f)
            {
                Boss.Instance.executer.SetCurrentState("Throw");
            }
        }

        if (isPounching)
        {
            Boss.Instance.executer.SetCurrentState("Pounce");
        }
    }

    public void OnReset()
    {
        this.transform.DOKill();
        this.transform.position = SpawningBoss.Instance.spawnPosition.position;
        this.transform.rotation = Quaternion.Euler(0, -90, 0);

        attackCount = 2;
        throwCount = 0;
        isAttacking = true;
        isPounching = false;
        isUpdate = true;

        Boss.Instance.health.currentHealth = Boss.Instance.health.maxHealth;
    }
}
