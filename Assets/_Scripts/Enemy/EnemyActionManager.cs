using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyActionManager : MonoBehaviour
{
    EnemyController controller;
    EnemyMovement movement;
    EnemyAttack attack;
    Rigidbody rb;

    private void Start()
    {
        rb = GetComponent<Rigidbody>();
        controller = GetComponent<EnemyController>();
        attack = GetComponent<EnemyAttack>();
        movement = GetComponent<EnemyMovement>();
    }

    public void DisableAction()
    {
        controller.enabled = false;
        movement.enabled = false;
        attack.enabled = false;
        rb.isKinematic = false;
    }

    public void EnableAction()
    {
        controller.enabled = false;
        movement.enabled = false;
        attack.enabled = false;
        rb.isKinematic = true;
    }
}
