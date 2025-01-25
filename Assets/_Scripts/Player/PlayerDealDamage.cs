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

    public void ObjectDetected()
    {
        float playerDirection = Mathf.Sign(Player.Instance.transform.rotation.eulerAngles.y);
        Physics.Raycast(ray.transform.position, ray.transform.forward * playerDirection, out hitInfo, sizeHit, hitLayer);
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
        if (hitInfo.collider != null)
        {
            CombatManager.Instance.DealtDamageEnemy(hitInfo);
        }
    }

    /*private void OnDrawGizmosSelected()
    {
        Gizmos.color = Color.green;
        float playerDirection = Mathf.Sign(Player.Instance.transform.rotation.eulerAngles.y);
        Gizmos.DrawRay(ray.transform.position, ray.transform.forward * playerDirection * sizeHit);
    }*/
}
