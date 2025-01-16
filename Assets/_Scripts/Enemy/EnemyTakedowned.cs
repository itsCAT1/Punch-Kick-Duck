using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyTakedowned : MonoBehaviour
{
    public Vector3 offset;
    EnemyController controller;
    EnemyMovement movement;
    EnemyAttack attack;
    public float forcePush = 4;
    Rigidbody rb;

    private void Start()
    {
        rb = GetComponent<Rigidbody>();
        controller = GetComponent<EnemyController>();
        attack = GetComponent<EnemyAttack>();
        movement = GetComponent<EnemyMovement>();
    }

    public void IsRepelled()
    {
        DisableAction();
        Vector3 pushDirection = new Vector3(transform.forward.x * offset.x, offset.y, offset.z).normalized;
        rb.AddForce(pushDirection * forcePush, ForceMode.Impulse);
    }

    public void DisableAction()
    {
        controller.enabled = false;
        movement.enabled = false;
        attack.enabled = false;
        rb.isKinematic = false;
    }
}
