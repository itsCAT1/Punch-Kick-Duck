using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FruitHandler : ColliderHandler
{
    FruitMovement fruitMovement;

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
        if (other.gameObject.CompareTag(attackType))
        {
            ReflectObject();
        }

        if (other.gameObject.CompareTag("Player"))
        {
            fruitMovement.forceSpeed = 0;

            PlayerOnHit();
            ObjectOnHit();
        }

        if (other.gameObject.CompareTag("Boss"))
        {
            fruitMovement.forceSpeed = 0;
            ObjectOnHit();
            DataPointManager.Instance.GainPoint();
        }
    }
}
