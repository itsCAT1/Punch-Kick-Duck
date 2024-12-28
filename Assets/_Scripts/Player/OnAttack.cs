using System;
using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

[Serializable]
public class AttackPoint
{
    public string name; 
    public Transform point; 
}

public class OnAttack : MonoBehaviour
{
    public float sizeAttack;
    public LayerMask hitLayer;
    public List<AttackPoint> attackPointList;

    public bool canDealDamage;
    public List<GameObject> hasDealDamage;

    private void Start()
    {
        canDealDamage = false;
        hasDealDamage = new List<GameObject>();
    }

    public void DealDamage(string pointName)
    {
        if (!canDealDamage) return;

        AttackPoint attackPoint = attackPointList.Find(ap => ap.name == pointName);

        if (attackPoint == null) return;

        Collider[] hits = Physics.OverlapSphere(attackPoint.point.position, sizeAttack, hitLayer);

        foreach (var target in hits)
        {
            if (!hasDealDamage.Contains(target.gameObject))
            {
                hasDealDamage.Add(target.gameObject);

                Debug.Log($"Da tan cong: {target.name}");
                Animator animator = target.GetComponent<Animator>();
                animator?.Play("Hurt");

                canDealDamage = false;
                break;
            }
        }
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
