using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyTakedowned : MonoBehaviour
{
    public Vector3 offset;
    public EnemyDetect controller;
    public EnemyMovement movement;
    public EnemyAttack attack;
    public float forcePush = 4;
    Rigidbody rb;

    private void Start()
    {
        rb = GetComponent<Rigidbody>();
    }

    public void IsRepelled()
    {
        DisableAction();
        Vector3 pushDirection = new Vector3(transform.forward.x * offset.x, offset.y, offset.z).normalized;
        rb.AddForce(pushDirection * forcePush, ForceMode.Impulse);
    }

    private void OnDrawGizmosSelected()
    {
        Gizmos.color = Color.yellow;
        Gizmos.DrawLine(this.transform.position, new Vector3(this.transform.forward.x * offset.x, offset.y, offset.z));
    }

    public void DisableAction()
    {
        controller.enabled = false;
        movement.enabled = false;
        attack.enabled = false;
        rb.isKinematic = false;
    }
}
