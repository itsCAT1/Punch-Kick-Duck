using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyController : MonoBehaviour
{
    Rigidbody rigid;
    public Animator animator;
    CharacterController characterController;
    EnemyAttack enemyAttack;

    public float moveSpeed;
    public LayerMask characterLayer;
    public float sizeDetect;

    void Start()
    {
        rigid = GetComponent<Rigidbody>();
        animator = GetComponent<Animator>();
        characterController = GetComponent<CharacterController>();
        enemyAttack = GetComponent<EnemyAttack>();
    }

    private void Update()
    {
        UpdateAction();
    }


    void UpdateAction()
    {
        bool aimingRay = Physics.Raycast(this.transform.position, this.transform.forward, out RaycastHit hitInfor, sizeDetect, characterLayer);
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
            this.rigid.isKinematic = false;
            PerformMove();
        }
    }

    void Standing()
    {
        animator.SetBool("Walking", false);
        this.rigid.isKinematic = true;
    }

    void PerformMove()
    {
        var direction = (Player.Instance.transform.position - transform.position).normalized;
        transform.rotation = Quaternion.LookRotation(direction);

        this.rigid.velocity = new Vector3(direction.x * moveSpeed * Time.deltaTime, direction.y, direction.z);
        //characterController.Move(direction * moveSpeed * Time.deltaTime);

        animator.SetBool("Walking", true);
    }
}
