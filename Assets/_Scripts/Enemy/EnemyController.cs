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

    [Header("Raycast Detect")] 
    public Transform rayDetect;
    public LayerMask charactorLayer;

    [Header("Enemy Type")]
    public bool haveBottle;
    public bool haveCart;

    [Header("Size Attack")]
    public float sizeAttack;
    public float sizeStand;
    public float sizeThrow;
    public float sizeHaveCart;
    public float currentRange;

    [Header("Attack Cooldown")]
    public float attackCoolDown = 1f;
    float timeCounter;
    public bool canAttack => timeCounter >= attackCoolDown;
    

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
        UpdateAction();
    }

    void UpdateAction()
    {
        bool aimingRay = Physics.Raycast(rayDetect.transform.position, rayDetect.transform.forward, out RaycastHit Infor, currentRange, charactorLayer);

        if (aimingRay)
        {
            if (Infor.collider.CompareTag("Player"))
            {
                Attack();
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

    void Attack()
    {
        Standing();
        timeCounter += Time.deltaTime;

        if (canAttack)
        {
            if (!AttackingEnemyManager.Instance.CanAttack(this.gameObject)) return;

            AttackingEnemyManager.Instance.SetAttackingEnemy(this.gameObject);

            if (haveBottle)
            {
                thowBottle.PerformThrowBottle();
            }
            else
            {
                attack.PerformAttack();
            }
            timeCounter = 0;
        }
    }

    void Standing()
    {
        animator.SetBool("Walking", false);
        animator.SetBool("HaveCart", false);
        movement.enabled = false;
        this.rigid.isKinematic = true;
    }

    void Moving()
    {
        SetWalkingType();
        movement.enabled = true;
        this.rigid.isKinematic = false;
    }

    public void SetWalkingType()
    {
        if (haveCart)
        {
            animator.SetBool("HaveCart", true);
            animator.SetBool("Walking", false);
        }
        else
        {
            animator.SetBool("HaveCart", false);
            animator.SetBool("Walking", true);
        }
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
