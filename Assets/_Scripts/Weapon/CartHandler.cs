using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

public class CartHandler : ColliderHandler
{
    bool hasColidered = false;
    Enemy enemy;

    void Start()
    {
        enemy = GetComponentInParent<Enemy>();
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.CompareTag("Player") && !hasColidered)
        {
            hasColidered = true;
            enemy.controller.haveCart = false;
            PlayerOnHit();
            ObjectOnHit();
        }

        if (other.gameObject.CompareTag("Punch") || other.gameObject.CompareTag("Kick") || other.gameObject.CompareTag("Duck"))
        {
            enemy.controller.haveCart = false;
            enemy.executer.SetCurrentState("GoBack");
            ObjectOnHit();
        }

        if (other.gameObject.CompareTag("Enemy"))
        {
            enemy.executer.SetCurrentState("GoBack");
        }
    }
}
