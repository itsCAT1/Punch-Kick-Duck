using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyHealth : Health
{
    Enemy enemy;

    private void Start()
    {
        currentHealth = maxHealth;
        enemy = GetComponent<Enemy>();
    }

    protected override void Dead()
    {
        enemy.executer.SetCurrentState("Dead");

        enemy.animator.Play("Die");
        GetComponent<Collider>().enabled = false;
        Destroy(gameObject, 2f);
    }
}
