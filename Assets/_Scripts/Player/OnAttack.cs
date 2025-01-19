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
    RaycastHit hitInfo;

    public void DetectObject() => Physics.Raycast(ray.transform.position, ray.transform.forward * Player.Instance.controller.facingDirection, out hitInfo, sizeHit, hitLayer);

    private void Update()
    {
        DetectObject();
    }

    public void DealDamage(AttackType type)
    {
        AttackMapper attack = attackList.Find(at => at.attackType == type);
        
        if (attack == null) return;

        if(hitInfo.collider != null)
        {
            CombatManager.Instance.ResolveCombat(attack, hitInfo);
        }
    }
}
