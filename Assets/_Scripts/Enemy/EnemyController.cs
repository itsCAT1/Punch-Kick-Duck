using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyController : MonoBehaviour
{
    Rigidbody rigid;
    Animator animator;

    public float moveSpeed;
    public Transform playerPos;

    public float attackDistance = 1f;
    public float timeCoolDown = 1f;
    float lastTimeAttack = 0;

    public Transform handPos;
    public Vector3 sizeHand;
    void Start()
    {
        rigid = GetComponent<Rigidbody>();
        animator = GetComponent<Animator>();
    }

    private void Update()
    {
        CheckAttack();
    }


    void CheckAttack()
    {
        if (Vector3.Distance(transform.position, playerPos.position) <= attackDistance)
        {
            animator.SetBool("Walking", false);
            PerformAttack();
        }
        else
        {
            PerformMove();
        }
    }


    void PerformMove()
    {
        var direction = (playerPos.position - transform.position).normalized;
        transform.rotation = Quaternion.LookRotation(direction);

        this.transform.position += direction * moveSpeed * Time.deltaTime;

        animator.SetBool("Walking", true);
    }

    void PerformAttack()
    {
        if(Time.time - lastTimeAttack >= timeCoolDown)
        {
            animator.Play("PunchRight");
            lastTimeAttack = Time.time;
        }
    }

    private void OnDrawGizmosSelected()
    {
        Gizmos.color = Color.red;
        Gizmos.DrawCube(handPos.position, sizeHand);
    }
}
