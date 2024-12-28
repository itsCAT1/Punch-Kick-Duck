using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyController : MonoBehaviour
{
    Rigidbody rigid;
    Animator animator;

    public float moveSpeed;
    public float attackDistance = 1f;
    public float timeCoolDown = 1f;
    float lastTimeAttack = 0;

    public Transform handPos;
    public LayerMask playerLayer;
    public float sizeHand;

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
        if (Vector3.Distance(transform.position, Player.Instance.transform.position) <= attackDistance)
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
        var direction = (Player.Instance.transform.position - transform.position).normalized;
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
        Gizmos.DrawSphere(handPos.position, sizeHand);
    }
}
