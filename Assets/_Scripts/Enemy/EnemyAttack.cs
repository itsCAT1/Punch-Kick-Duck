using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyAttack : MonoBehaviour
{
    public Animator animator;
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
            animator.Play("PunchRight");
            lastTimeAttack = Time.time;
        }
    }
}
