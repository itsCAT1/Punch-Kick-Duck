using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ColiderCart : HandleColider
{
    bool hasColidered = false;
    EnemyActionHandle actionEnemy;

    void Start()
    {
        actionEnemy = GetComponentInParent<EnemyActionHandle>();
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.CompareTag("Player") && !hasColidered)
        {
            hasColidered = true;
            PlayerOnHit();
            ObjectOnHit();
            StartCoroutine(DestroyObject());
        }

        if (other.gameObject.CompareTag(attackType))
        {
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
