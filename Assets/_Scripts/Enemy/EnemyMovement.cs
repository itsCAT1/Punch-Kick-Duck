using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyMovement : MonoBehaviour
{
    Animator animator;
    public float moveSpeed;

    private void Start()
    {
        animator = GetComponent<Animator>();
    }

    public void Update()
    {
        PerformMove();
    }

    void PerformMove()
    {
        var direction = (Player.Instance.transform.position - transform.position).normalized;
        transform.rotation = Quaternion.LookRotation(direction);

        this.transform.position += direction * moveSpeed * Time.deltaTime;
    }
}
