using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BottleHandler : ColiderHandler
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
        if (other.gameObject.CompareTag(attackType))
        {
            ReflectObject();
        }

        if (other.gameObject.CompareTag("Player") && ConditionManger.Instance.startGame)
        {
            bottleMovement.forceSpeed = 0;

            PlayerOnHit();
            ObjectOnHit();
            StartCoroutine(DestroyObject());
        }

        if (other.gameObject.CompareTag("Enemy") && ConditionManger.Instance.startGame)
        {
            other.GetComponent<EnemyHealth>().TakeDamage();

            bottleMovement.forceSpeed = 0;
            ObjectOnHit();
            CombatManager.Instance.AddPoint();
            StartCoroutine(DestroyObject());
        }
    }
}
