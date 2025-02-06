using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyController : MonoBehaviour
{
    Rigidbody rigid;
    Animator animator;
    EnemyAttack attack;
    EnemyMovement movement;
    EnemyThrowBottle thowBottle;
    DetectingObject detect;
    EnemyApear apear;
    Health health;

    public Transform rayDetect;
    public LayerMask charactorLayer;
    public float sizeAttack;
    public float sizeThrow;
    public bool haveBottle;

    public float currentRange;

    void Start()
    {
        rigid = GetComponent<Rigidbody>();
        animator = GetComponent<Animator>();
        attack = GetComponent<EnemyAttack>();
        movement = GetComponent<EnemyMovement>();
        detect = GetComponent<DetectingObject>();
        apear = GetComponent<EnemyApear>();
        health = GetComponent<Health>();

        if (haveBottle) thowBottle = GetComponent<EnemyThrowBottle>();
    }

    private void Update()
    {
        CheckObject();
    }

    void CheckObject()
    {
        bool aimingRay = Physics.Raycast(rayDetect.transform.position, rayDetect.transform.forward, out RaycastHit Infor, currentRange, charactorLayer);

        if (aimingRay)
        {
            if (Infor.collider.CompareTag("Player"))
            {
                Standing();
                if (haveBottle)
                {
                    thowBottle.PerformThrowBottle();
                }
                else
                {
                    attack.PerformAttack();
                }
            }
            else if (Infor.collider.CompareTag("Enemy"))
            {
                Standing();
            }
        }
        else
        {
            Moving();
        }
    }

    void Standing()
    {
        animator.SetBool("Walking", false);
        movement.enabled = false;
        this.rigid.isKinematic = true;
    }

    void Moving()
    {
        animator.SetBool("Walking", true);
        movement.enabled = true;
        this.rigid.isKinematic = false;
    }

    private void OnDrawGizmosSelected()
    {
        Gizmos.color = haveBottle ? Color.blue : Color.red;
        Gizmos.DrawRay(rayDetect.transform.position, rayDetect.transform.forward * sizeAttack);
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.CompareTag("OpenableDoor"))
        {
            apear.enabled = true;
        }
    }

    private void OnCollisionEnter(Collision collision)
    {
        if (collision.gameObject.CompareTag("Boss"))
        {
            health.TakeDamage();
        }
    }
}
