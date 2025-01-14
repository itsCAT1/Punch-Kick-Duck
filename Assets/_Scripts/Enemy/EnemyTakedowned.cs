using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyTakedowned : MonoBehaviour
{
    public EnemyController controller;
    public EnemyMovement movement;
    public float forcePush = 4;
    Rigidbody rb;

    private void Start()
    {
        rb = GetComponent<Rigidbody>();
    }

    public void IsRepelledEnemy()
    {
        rb.isKinematic = false;
        movement.enabled = false;
        controller.enabled = false;

        Vector3 endPos = (this.transform.position - new Vector3(this.transform.forward.x, -5f, 3)).normalized;

        rb.AddForce(endPos * forcePush, ForceMode.Impulse);
    }
}
