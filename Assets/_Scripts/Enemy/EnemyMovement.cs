using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyMovement : MonoBehaviour
{
    public Animator animator;
    public float moveSpeed;

    private void Start()
    {
        animator = GetComponent<Animator>();
    }

    public void Update()
    {
        var direction = (Player.Instance.transform.position - transform.position).normalized;
        transform.rotation = Quaternion.LookRotation(direction);

        this.transform.position += direction * moveSpeed * Time.deltaTime;

        animator.SetBool("Walking", true);
    }
}
