using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ColiderBottle : HandleColider
{
    BottleMovement bottleMovement;

    void Start()
    {
        bottleMovement = GetComponent<BottleMovement>();
    }

    public void ReflectObject()
    {
        this.transform.rotation = Quaternion.Euler(0, -this.transform.eulerAngles.y, 0);
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.CompareTag(attackType))
        {
            ReflectObject();
        }

        if (other.gameObject.CompareTag("Player"))
        {
            PlayerOnHit();
            ObjectOnHit();
            StartCoroutine(DestroyObject());
        }

        if (other.gameObject.CompareTag("Enemy"))
        {
            other.GetComponent<EnemyHealth>().TakeDamage();
            ObjectOnHit();
            StartCoroutine(DestroyObject());
        }
    }
}
