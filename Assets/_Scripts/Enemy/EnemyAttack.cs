using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyAttack : MonoBehaviour
{
    Animator animator;

    public float timeCoolDown = 1f;
    float lastTimeAttack = 0;

    void Start()
    {
        animator = GetComponent<Animator>();
    }

    public void PerformAttack()
    {
        if (Time.time - lastTimeAttack >= timeCoolDown)
        {
            animator.Play("Attack");
            lastTimeAttack = Time.time;
        }
    }

    public void DealDamage()
    {
        Player.Instance.health.TakeDamage();
        Player.Instance.health.PerformHurt();
    }

    public void EnableBlock()
    {
        CombatManager.Instance.canBlock = true;
    }

    public void DisableBlock()
    {
        CombatManager.Instance.canBlock = false;
    }
}
