using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyActionHandle : MonoBehaviour
{
    Animator animator;
    EnemyController controller;
    EnemyMovement movement;
    EnemyAttack attack;

    private void Start()
    {
        animator = GetComponent<Animator>();
        controller = GetComponent<EnemyController>();
        attack = GetComponent<EnemyAttack>();
        movement = GetComponent<EnemyMovement>();
    }

    public void DisableAction()
    {
        animator.SetBool("Walking", false);
        animator.SetBool("HaveCart", false);
        controller.enabled = false;
        attack.enabled = false;
        movement.enabled = false;
    }

    public void EnableAction()
    {
        controller.enabled = true;
        attack.enabled = true;
        movement.enabled = true;
    }
}
