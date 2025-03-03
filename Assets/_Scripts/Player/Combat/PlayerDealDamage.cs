using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

public class PlayerDealDamage : MonoBehaviour
{
    public LayerMask hitLayer;
    public Transform ray;
    public RaycastHit hitInfo;

    public float currentRange;


    public bool aimingRay => Physics.Raycast(ray.transform.position, ray.transform.forward, out hitInfo, currentRange, hitLayer);


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
        if(aimingRay)
        {
            if (hitInfo.collider.CompareTag("Enemy"))
            {
                CombatManager.Instance.DealtDamageEnemy(hitInfo);
            }

            if (hitInfo.collider.CompareTag("Boss"))
            {
                CombatManager.Instance.DealtDamageBoss();
            }
        }
    }
}
