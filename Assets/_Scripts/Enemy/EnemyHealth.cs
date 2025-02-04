using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyHealth : Health
{
    EnemyBeaten enemy;
    Animator animator;

    private void Start()
    {
        currentHealth = maxHealth;
        animator = GetComponent<Animator>();
        enemy = GetComponent<EnemyBeaten>();
    }

    protected override void Dead()
    {
        enemy.EnemyIsBeaten();

        animator.Play("Die");
        GetComponent<Collider>().enabled = false;

        Destroy(gameObject, 2f);
    }
}
