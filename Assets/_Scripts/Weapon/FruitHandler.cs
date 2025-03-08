using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FruitHandler : ColliderHandler
{
    FruitMovement fruitMovement;
    public AudioSource hitSound, reflectSound;

    void Start()
    {
        fruitMovement = GetComponent<FruitMovement>();
    }

    public void ReflectObject()
    {
        fruitMovement.forceSpeed = 25;
        this.transform.rotation = Quaternion.Euler(0, -this.transform.eulerAngles.y, 0);
        CreateHitEffect();
        reflectSound.Play();
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


        if (other.gameObject.CompareTag("Player") && ConditionManger.Instance.currentState == GameState.InGame)
        {
            CanDealDamage();
        }

        if (other.gameObject.CompareTag("Boss") && ConditionManger.Instance.currentState == GameState.InGame)
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
            hitSound.Play();
        }
    }
}
