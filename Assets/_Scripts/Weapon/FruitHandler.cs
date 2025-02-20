using System.Collections;
using System.Collections.Generic;
using UnityEditor.PackageManager;
using UnityEngine;

public class FruitHandler : ColliderHandler
{
    FruitMovement fruitMovement;
    public LayerMask hitLayer;
    public Transform ray;
    public RaycastHit hitInfo;

    public bool aimingRay => Physics.Raycast(this.transform.position, this.transform.forward, out hitInfo, 3, hitLayer);

    void Start()
    {
        fruitMovement = GetComponent<FruitMovement>();
    }

    public void ReflectObject()
    {
        fruitMovement.forceSpeed = 25;
        this.transform.rotation = Quaternion.Euler(0, -this.transform.eulerAngles.y, 0);
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.CompareTag("Punch"))
        {
            if (this.attackType == AttackType.Punch)
            {
                ReflectObject();
            }
        }

        if (other.gameObject.CompareTag("Kick"))
        {
            if (this.attackType == AttackType.Kick)
            {
                ReflectObject();
            }
        }


        if (other.gameObject.CompareTag("Player") && ConditionManger.Instance.startGame)
        {
            CanDealDamage();
        }

        if (other.gameObject.CompareTag("Boss") && ConditionManger.Instance.startGame)
        {
            Boss.Instance.health.TakeDamage();
            fruitMovement.forceSpeed = 0;
            ObjectOnHit();
            DataPointManager.Instance.GainPoint();
        }
    }

    void CanDealDamage()
    {
        if (Player.Instance.attackType.type == AttackType.Duck && this.attackType == AttackType.Duck && CombatManager.Instance.playerIsAttacking) return;

        else
        {
            fruitMovement.forceSpeed = 0;
            PlayerOnHit();
            ObjectOnHit();
        }
    }
}
