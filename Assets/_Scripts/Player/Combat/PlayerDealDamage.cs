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
    public GameObject hitVFXPrefab;
    public GameObject blockVFXPrefab;
    public Transform[] hitPosition;
    Transform currentHitPosition;


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

    public void CreateHitEffect()
    {
        if (Player.Instance.attackType.type == AttackType.Punch) currentHitPosition = hitPosition[0];
        else if (Player.Instance.attackType.type == AttackType.Kick) currentHitPosition = hitPosition[1];
        else if (Player.Instance.attackType.type == AttackType.Duck) currentHitPosition = hitPosition[2];

        Instantiate(hitVFXPrefab, currentHitPosition.position, Quaternion.identity);
    }

    public void CreateBlockEffect()
    {
        if (Player.Instance.attackType.type == AttackType.Punch) currentHitPosition = hitPosition[0];
        else if (Player.Instance.attackType.type == AttackType.Kick) currentHitPosition = hitPosition[1];
        else if (Player.Instance.attackType.type == AttackType.Duck) currentHitPosition = hitPosition[2];

        Instantiate(blockVFXPrefab, currentHitPosition.position, Quaternion.identity);
    }
}
