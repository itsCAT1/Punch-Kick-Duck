using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BossController : MonoBehaviour
{
    public float attackCoolDown = 2;
    public float timeAttack;
    public float timePounces;
    public float pouncesCooldown = 10;

    public bool canAttack => Time.time - timeAttack >= attackCoolDown;
    public bool playerInRange => Vector3.Distance(transform.position, Player.Instance.transform.position) <= 3f;

    public bool canPounces => Time.time - timePounces >= pouncesCooldown;

    void Start()
    {
        
    }


    void Update()
    {
        UpdateAction();
    }

    void UpdateAction()
    {
        if (Input.GetKeyDown(KeyCode.Z))
        {
            Boss.Instance.pounce.Pounce();
            timePounces = Time.time;
            return;
        }

        if (Input.GetKeyDown(KeyCode.X))
        {
            Attack();
            timeAttack = Time.time;
        }
    }

    public void Attack()
    {
        Boss.Instance.animator.Play("Punch");
        //Boss.Instance.attackType.type = (AttackType)Random.Range(0, 3);

        //Boss.Instance.executer.SetTrigger("Attack");
    }
}
