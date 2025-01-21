using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MiniBossAttack : MonoBehaviour
{
    Animator animator;
    PerformPushPlayer pushPlayer;

    public float timeCoolDown = 1f;
    float lastTimeAttack = 0;

    void Start()
    {
        animator = GetComponent<Animator>();
        pushPlayer = GetComponent<PerformPushPlayer>();
    }

    private void Update()
    {
        PerformAttack();
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

        pushPlayer.PerformPush();
    }
}
