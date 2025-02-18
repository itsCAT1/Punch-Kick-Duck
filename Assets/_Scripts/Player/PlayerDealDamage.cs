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

    public void ObjectDetected()
    {
        if (CombatManager.Instance.inBossArea) sizeAttack = 3.5f;

        else sizeAttack = 2f;

        float playerDirection = Mathf.Sign(Player.Instance.transform.rotation.eulerAngles.y);
        Physics.Raycast(ray.transform.position, ray.transform.forward * playerDirection, out hitInfo, sizeAttack, hitLayer);
    }

    private void Update()   
    {
        ObjectDetected();
        DetectDoor();
    }

    public void GetAttackType(AttackType type)
    {
        Player.Instance.attackType.type = type;
    }

    public void StartAttack(AttackType type)
    {
        GetAttackType(type);
        CombatManager.Instance.playerIsAttacking = true;

        CancelInvoke(nameof(StopAttack));
        Invoke(nameof(StopAttack), 0.4f); 
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

    void DetectDoor()
    {
        if (hitInfo.collider != null && hitInfo.collider.CompareTag("OpenableDoor"))
        {
            Player.Instance.controller.reachedDoor = true;
            return;
        }
        
        Player.Instance.controller.reachedDoor = false;
    }

}
