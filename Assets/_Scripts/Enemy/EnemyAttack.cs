using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyAttack : MonoBehaviour
{
    Animator animator;
    EnemyController enemyController;

    public float timeCoolDown = 1f;
    float lastTimeAttack = 0;

    public Transform bottlePosition;
    public GameObject bottlePrefab;

    void Start()
    {
        animator = GetComponent<Animator>();
        enemyController = GetComponent<EnemyController>();
    }

    public void PerformAttack()
    {
        if (Time.time - lastTimeAttack >= timeCoolDown)
        {
            animator.Play("Attack");
            lastTimeAttack = Time.time;
        }
    }

    public void PerformThrowBottle()
    {
        animator.Play("AttackBottle");
        enemyController.haveBottle = false;
    }

    public void CreateBottle()
    {
        Instantiate(bottlePrefab, bottlePosition.position, Quaternion.identity);
    }

    public void PlayerTakeDamage()
    {
        Player.Instance.performAttack.PerformHurt();
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
