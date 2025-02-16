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
    public LayerMask hitLayer;

    public float sizeAttack;
    public Transform ray;
    RaycastHit hitInfo;

    public bool isAttacking = false;

    public void ObjectDetected()
    {
        float playerDirection = Mathf.Sign(Player.Instance.transform.rotation.eulerAngles.y);
        Physics.Raycast(ray.transform.position, ray.transform.forward * playerDirection, out hitInfo, sizeAttack, hitLayer);
    }

    private void Update()   
    {
        ObjectDetected();
    }

    public void GetAttackType(AttackType type)
    {
        Player.Instance.attackType.type = type;
    }

    public void StartAttack(AttackType type)
    {
        GetAttackType(type);
        CombatManager.Instance.playerIsAttacking = true;

        Invoke(nameof(StopAttack), 0.5f); 
    }

    public void StopAttack()
    {
        CombatManager.Instance.playerIsAttacking = false;
    }

    public void DealDamage()
    {
        if (hitInfo.collider != null && hitInfo.collider.CompareTag("Enemy"))
        {
            CombatManager.Instance.DealtDamageEnemy(hitInfo);
        }

        if (hitInfo.collider != null && hitInfo.collider.CompareTag("Boss"))
        {
            CombatManager.Instance.DealtDamageBoss();
        }
    }
}
