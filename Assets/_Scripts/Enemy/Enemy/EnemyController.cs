using FSMC.Runtime;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyController : MonoBehaviour
{
    Enemy enemy;

    [Header("Raycast Detect")] 
    public Transform rayDetect;
    public LayerMask charactorLayer;

    [Header("Enemy Type")]
    public bool haveBottle;
    public bool haveCart;

    [Header("Size Attack")]
    public float currentRange;

    [Header("Attack Cooldown")]
    public float attackCoolDown = 1f;
    float timeCounter;

    public bool canAttack = true;

    private void Start()
    {
        enemy = GetComponent<Enemy>();
    }

    private void Update()
    {
        UpdateAction();
    }

    void UpdateAction()
    {
        if (!canAttack) return;
        if (enemy.executer.GetCurrentState() == null) return;

        bool aimingRay = Physics.Raycast(rayDetect.transform.position, rayDetect.transform.forward, out RaycastHit Infor, currentRange, charactorLayer);
        
        if (aimingRay)
        {
            if (Infor.collider.CompareTag("Player"))
            {
                if (haveBottle)
                {
                    Debug.Log("throw");
                    enemy.executer.SetCurrentState("Throw");
                }
                else
                {
                    enemy.executer.SetCurrentState("Attack");
                }
            }
            else if (Infor.collider.CompareTag("Enemy"))
            {
                enemy.executer.SetCurrentState("Idle");
            }
        }
        else
        {
            enemy.executer.SetCurrentState("Walk");
        }
    }

    public void Attack()
    {
        if (!AttackingEnemyManager.Instance.CanAttack(this.gameObject)) return;

        AttackingEnemyManager.Instance.SetAttackingEnemy(this.gameObject);

        if (haveBottle)
        {
            enemy.executer.SetCurrentState("Throw");
        }
        else
        {
            enemy.executer.SetCurrentState("Attack");
        }
    }

    public void Standing()
    {
        enemy.animator.SetBool("Walking", false);
        enemy.animator.SetBool("HaveCart", false);
    }

    public void Moving()
    {
        SetWalkingType();
    }

    public void SetWalkingType()
    {
        if (haveCart)
        {
            enemy.animator.SetBool("HaveCart", true);
            enemy.animator.SetBool("Walking", false);
        }
        else
        {
            enemy.animator.SetBool("HaveCart", false);
            enemy.animator.SetBool("Walking", true);
        }
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.CompareTag("OpenableDoor"))
        {
            enemy.apear.enabled = true;
        }
    }

    private void OnCollisionEnter(Collision collision)
    {
        if (collision.gameObject.CompareTag("Boss"))
        {
            enemy.health.TakeDamage();
        }
    }
}
