using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEditor;
using UnityEngine;
using Lean.Pool;

public enum AttackType
{
    punch,
    kick,
    duck,
}

[Serializable]
public class AttackMapper
{
    public AttackType attackType;
    public Transform point;
}

public class OnAttack : MonoBehaviour
{
    public float sizeAttack;
    public LayerMask hitLayer;
    public List<AttackMapper> attackList;

    public bool canDealDamage;
    public List<GameObject> hasDealDamage;
    public bool isBlocking = false;

    private void Start()
    {
        canDealDamage = false;
        hasDealDamage = new List<GameObject>();
    }

    public void DealDamage(AttackType type)
    {
        if (!canDealDamage) return;

        AttackMapper attack = attackList.Find(ap => ap.attackType == type);

        if (attack == null) return;

        DetectCharactor(attack);
    }

    void DetectCharactor(AttackMapper attackPoint)
    {
        Collider[] hits = Physics.OverlapSphere(attackPoint.point.position, sizeAttack, hitLayer);

        foreach (var target in hits)
        {
            if (!hasDealDamage.Contains(target.gameObject))
            {
                hasDealDamage.Add(target.gameObject);
                LeanPool.Despawn(target.gameObject);
                Debug.Log("gay damage bang " + (attackPoint.attackType));
                //Blocking(target.gameObject);

                canDealDamage = false;
                break;
            }
        }   
    }

    void Blocking(GameObject target)
    {
        Animator animator = target.GetComponentInParent<Animator>();
        EnemyAttack currentType = target.GetComponent<EnemyAttack>();

        if (isBlocking)
        {
            StartCoroutine(OnBlocked());
            animator?.Play("Idle");
            isBlocking = false;
        }
        else
        {
            animator?.Play("Hurt");
        }
    }

    IEnumerator OnBlocked()
    {
        Time.timeScale = 0;
        yield return new WaitForSecondsRealtime(1);
        Time.timeScale = 1;
    }

    public void EnableDamage()
    {
        canDealDamage = true;
    }

    public void DisableDamage()
    {
        canDealDamage = false;
        hasDealDamage.Clear();
    }
}
