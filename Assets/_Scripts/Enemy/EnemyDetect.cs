using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyDetect : MonoBehaviour
{
    Rigidbody rigid;
    public Animator animator;
    EnemyAttack enemyAttack;

    
    public Transform rayDetect;
    public LayerMask characterLayer;
    public float sizeDetect;

    public EnemyMovement enemyMovement;

    void Start()
    {
        rigid = GetComponent<Rigidbody>();
        animator = GetComponent<Animator>();
        enemyAttack = GetComponent<EnemyAttack>();
    }

    private void Update()
    {
        UpdateAction();
    }

    void UpdateAction()
    {
        bool aimingRay = Physics.Raycast(rayDetect.transform.position, rayDetect.transform.forward * sizeDetect, out RaycastHit hitInfor, sizeDetect, characterLayer);
        if (aimingRay)
        {
            if (hitInfor.collider.CompareTag("Player"))
            {
                Standing();
                enemyAttack.PerformAttack();
            }
            else if (hitInfor.collider.CompareTag("Enemy"))
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
        Gizmos.color = Color.red;
        Gizmos.DrawRay(rayDetect.transform.position, rayDetect.transform.forward * sizeDetect);
    }
}
