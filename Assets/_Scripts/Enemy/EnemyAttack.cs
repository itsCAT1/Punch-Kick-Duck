using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyAttack : MonoBehaviour
{
    Animator animator;
    PerformPushPlayer pushPlayer;
    AttackType enemyType;

    public float timeCoolDown = 1f;
    float lastTimeAttack = 0;

    void Start()
    {
        animator = GetComponent<Animator>();
        pushPlayer = GetComponent<PerformPushPlayer>();
        enemyType = GetComponent<EnemyType>().attackType;
    }

    public void PerformAttack()
    {
        if (Time.time - lastTimeAttack >= timeCoolDown)
        {
            animator.Play("Attack");
            lastTimeAttack = Time.time;
        }
    }

    public void CheckPlayer()
    {
        AttackType playerAttackType = Player.Instance.attackType.type;
        if(playerAttackType == enemyType && CombatManager.Instance.playerIsAttacking)
        {
            animator.Play("Block");
            CombatManager.Instance.BlockDamage(playerAttackType);
        }

        else
        {
            DealDamage();
        }
    }

    public void DealDamage()
    {
        Player.Instance.health.TakeDamage();

        pushPlayer.PerformPush();
    }
}
