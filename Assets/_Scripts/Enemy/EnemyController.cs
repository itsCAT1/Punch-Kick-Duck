using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyController : MonoBehaviour
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
                enemyMovement.enabled = false;
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
            this.rigid.isKinematic = false;
            enemyMovement.enabled = true;
        }
    }

    void Standing()
    {
        animator.SetBool("Walking", false);
        this.rigid.isKinematic = true;
    }

    

    private void OnDrawGizmosSelected()
    {
        Gizmos.color = Color.red;
        Gizmos.DrawRay(rayDetect.transform.position, rayDetect.transform.forward * sizeDetect);
    }
}
