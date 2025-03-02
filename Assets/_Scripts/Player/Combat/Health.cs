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

    public bool isDead => currentHealth <= 0;

    public virtual void TakeDamage()
    {
        if(isDead) return;

        currentHealth--;

        if (isDead)
        {
            Dead();
        }

        else
        {
            Hurt();
        }
    }

    protected virtual void Hurt()
    {

    }

    protected virtual void Dead()
    {
        
    }
}
