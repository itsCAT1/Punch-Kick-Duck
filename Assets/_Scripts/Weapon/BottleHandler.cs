using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BottleHandler : ColliderHandler
{
    BottleMovement bottleMovement;

    void Start()
    {
        bottleMovement = GetComponent<BottleMovement>();
    }

    public void ReflectObject()
    {
        bottleMovement.forceSpeed = 15;
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

        if (other.gameObject.CompareTag("Enemy") && ConditionManger.Instance.startGame)
        {
            other.GetComponent<EnemyHealth>().TakeDamage();

            bottleMovement.forceSpeed = 0;
            ObjectOnHit();
            DataPointManager.Instance.GainPoint();
        }
    }

    void CanDealDamage()
    {
        if (Player.Instance.attackType.type == AttackType.Duck && this.attackType == AttackType.Duck && CombatManager.Instance.playerIsAttacking) return;

        else
        {
            bottleMovement.forceSpeed = 0;
            PlayerOnHit();
            ObjectOnHit();
        }
    }
}
