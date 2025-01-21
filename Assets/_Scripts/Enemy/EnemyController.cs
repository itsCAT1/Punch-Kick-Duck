using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyController : MonoBehaviour
{
    Rigidbody rigid;
    Animator animator;
    EnemyAttack enemyAttack;
    EnemyMovement enemyMovement;
    EnemyThrowBottle enemyThrowBottle;

    public Transform rayDetect;
    public LayerMask charactorLayer;
    public float sizeAttack;
    public float sizeThrow;
    public bool haveBottle;

    float currentRange;

    void Start()
    {
        rigid = GetComponent<Rigidbody>();
        animator = GetComponent<Animator>();
        enemyAttack = GetComponent<EnemyAttack>();
        enemyMovement = GetComponent<EnemyMovement>();

        if(haveBottle) enemyThrowBottle = GetComponent<EnemyThrowBottle>();
    }

    private void Update()
    {
        UpdateAction();
    }

    void UpdateAction()
    {
        SetRangeAttack();
        CheckObject();
    }

    void SetRangeAttack()
    {
        Physics.Raycast(rayDetect.transform.position, rayDetect.transform.forward, out RaycastHit hitInfor, 1000, charactorLayer);
        if (hitInfor.collider == null)
        {
            return;
        }
        if (hitInfor.collider.CompareTag("Enemy"))
        {
            currentRange = sizeAttack;
        }

        if (hitInfor.collider.CompareTag("Player") && !haveBottle)
        {
            currentRange = sizeAttack;
        }

        if (hitInfor.collider.CompareTag("Player") && haveBottle)
        {
            currentRange = sizeThrow;
        }
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
                    enemyThrowBottle.PerformThrowBottle();
                }
                else
                {
                    enemyAttack.PerformAttack();
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
        enemyMovement.enabled = false;
        this.rigid.isKinematic = true;
    }

    void Moving()
    {
        animator.SetBool("Walking", true);
        enemyMovement.enabled = true;
        this.rigid.isKinematic = false;
    }

    private void OnDrawGizmosSelected()
    {
        Gizmos.color = haveBottle ? Color.blue : Color.red;
        Gizmos.DrawRay(rayDetect.transform.position, rayDetect.transform.forward * sizeAttack);
    }
}
