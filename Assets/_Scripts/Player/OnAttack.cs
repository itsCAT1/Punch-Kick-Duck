using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEditor;
using UnityEngine;

public enum AttackType
{
    Punch,
    Kick,
    Duck,
}

[Serializable]
public class AttackMapper
{
    public AttackType attackType;
}

public class OnAttack : MonoBehaviour
{
    public float sizeAttack;
    public LayerMask hitLayer;
    public List<AttackMapper> attackList;

    public bool canDealDamage = false;
    public bool isBlocking = false;
    public float sizeHit;

    public Transform ray;

    public void DealDamage(AttackType type)
    {
        if (!canDealDamage) return;

        AttackMapper attack = attackList.Find(at => at.attackType == type);
        
        if (attack == null) return;

        bool hasCollided = Physics.Raycast(ray.transform.position, ray.transform.forward, out RaycastHit hitInfo, sizeHit, hitLayer);

        if(hitInfo.collider != null)
        {
            //Debug.Log(attack.attackType);
            
            CombatManager.Instance.ResolveCombat(attack, hitInfo);
            canDealDamage = false;
        }
    }

    public void EnableDamage()
    {
        canDealDamage = true;
    }

    public void DisableDamage()
    {
        canDealDamage = false;
    }

    private void OnDrawGizmosSelected()
    {
        Gizmos.color = Color.red;
        Gizmos.DrawRay(ray.transform.position, ray.transform.forward * sizeHit);
    }
}
