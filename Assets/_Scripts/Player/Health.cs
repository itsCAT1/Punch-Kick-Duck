using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

public class Health : MonoBehaviour
{
    public int currentHealth;
    public int maxHealth;

    private void Start()
    {
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

    protected virtual void Die()
    {
        
    }
}
