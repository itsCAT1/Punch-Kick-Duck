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

public class PlayerDealDamage : MonoBehaviour
{
    public float sizeAttack;
    public LayerMask hitLayer;

    public float sizeHit;
    public Transform ray;
    RaycastHit hitInfo;

    public bool isAttacking = false;

    public void DetectObject()
    {
        Physics.Raycast(ray.transform.position, ray.transform.forward * Player.Instance.controller.facingDirection, out hitInfo, sizeHit, hitLayer);
    }

    private void Update()
    {
        DetectObject();
    }

    public void GetAttackType(AttackType type)
    {
        Player.Instance.attackType.type = type;
    }

    public void StartAttack(AttackType type)
    {
        GetAttackType(type);
        CombatManager.Instance.playerIsAttacking = true;

        Invoke(nameof(StopAttack), 0.4f); 
    }

    public void StopAttack()
    {
        CombatManager.Instance.playerIsAttacking = false;
    }

    public void DealDamage()
    {
        if (hitInfo.collider != null)
        {
            CombatManager.Instance.DealtDamageEnemy(hitInfo);
        }
    }
}
