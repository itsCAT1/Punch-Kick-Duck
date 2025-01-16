using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

public class Health : MonoBehaviour
{
    Rigidbody rb;
    public EnemyTakedowned enemyTakedowned;

    public int currentHealth;
    public int maxHealth;

    private void Start()
    {
        rb = GetComponent<Rigidbody>();
        currentHealth = maxHealth;
    }

    bool isDead => currentHealth <= 0;

    public void TakeDamage()
    {
        if(isDead) return;

        currentHealth--;

        if (isDead)
        {
            Die();
        }
    }

    public void Die()
    {
        enemyTakedowned.IsRepelled();

        GetComponent<Collider>().enabled = false;

        Destroy(gameObject, 2f);
    }
}
