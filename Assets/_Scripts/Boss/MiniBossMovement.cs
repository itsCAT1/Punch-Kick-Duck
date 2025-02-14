using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MiniBossMovement : MonoBehaviour
{
    Rigidbody rigid;
    public float moveSpeed;

    private void Start()
    {
        rigid = GetComponent<Rigidbody>();
    }

    private void Update()
    {
        PerformMove();
    }

    public void PerformMove()
    {
        var direction = (Player.Instance.transform.position - transform.position).normalized;
        transform.rotation = Quaternion.LookRotation(direction);

        rigid.velocity = direction * moveSpeed;
    }
}
