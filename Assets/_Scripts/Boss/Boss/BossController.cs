using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BossController : MonoBehaviour
{
    public bool isUpdate = true;
    public int attackCount = 3;
    public int throwCount = 0;

    public float distanceAttack;

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
        if (isAttacking)
        {
            float distance = Vector3.Distance(Player.Instance.transform.position, Boss.Instance.transform.position);
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
            Boss.Instance.executer.SetCurrentState("Throw");
        }

        if (isPounching)
        {
            Boss.Instance.executer.SetCurrentState("Pounce");
        }
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.CompareTag("Player"))
        {
            CanDealDamage();
        }
    }

    void CanDealDamage()
    {
        if (Player.Instance.attackType.type == AttackType.Duck && CombatManager.Instance.playerIsAttacking) return;

        else
        {
            Player.Instance.health.TakeDamage();
            DataPointManager.Instance.LosePoint();
        }
    }
}
