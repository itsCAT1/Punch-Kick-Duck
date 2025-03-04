using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MiniBossController : MonoBehaviour
{
    Animator animator;
    Rigidbody rigid;
    MiniBossAttack attack;
    MiniBossMovement movement;

    public float sizeDetect;

    void Start()
    {
        animator = GetComponent<Animator>();
        rigid = GetComponent<Rigidbody>();
        attack = GetComponent<MiniBossAttack>();
        movement = GetComponent<MiniBossMovement>();
    }

    void Update()
    {
        DetectPlayer();
    }

    void DetectPlayer()
    {
        if (Vector3.Distance(this.transform.position, Player.Instance.transform.position) > sizeDetect)
        {
            Moving();
        }
        else
        {
            Standing();
        }
    }

    void Standing()
    {
        animator.Play("Idle");
        animator.SetBool("Walking", false);
        attack.enabled = true;
        movement.enabled = false;
        this.rigid.isKinematic = true;
    }

    void Moving()
    {
        animator.Play("Walk");
        animator.SetBool("Walking", true);
        attack.enabled = false;
        movement.enabled = true;
        this.rigid.isKinematic = false;
    }
}
