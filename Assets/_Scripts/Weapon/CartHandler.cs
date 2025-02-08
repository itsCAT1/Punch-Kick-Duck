using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CartHandler : HandleColider
{
    bool hasColidered = false;
    EnemyController controller;
    EnemyActionHandle actionEnemy;

    void Start()
    {
        actionEnemy = GetComponentInParent<EnemyActionHandle>();
        controller = GetComponentInParent<EnemyController>();
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.CompareTag("Player") && !hasColidered)
        {
            hasColidered = true;
            controller.haveCart = false;
            PlayerOnHit();
            ObjectOnHit();
            StartCoroutine(DestroyObject());
        }

        if (other.gameObject.CompareTag(attackType))
        {
            controller.haveCart = false;
            ObjectOnHit();
            StartCoroutine(StopActionEnemy());
            StartCoroutine(DestroyObject());
        }
    }

    IEnumerator StopActionEnemy()
    {
        actionEnemy.DisableAction();
        yield return new WaitForSeconds(2);
        actionEnemy.EnableAction();
    }
}
