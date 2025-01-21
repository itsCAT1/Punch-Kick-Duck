using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MiniBossActionManager : MonoBehaviour
{
    Animator animator;
    MiniBossController controller;
    MiniBossMovement movement;
    MiniBossAttack attack;

    private void Start()
    {
        animator = GetComponent<Animator>();
        controller = GetComponent<MiniBossController>();
        attack = GetComponent<MiniBossAttack>();
        movement = GetComponent<MiniBossMovement>();
    }
    [ContextMenu("disable")]
    public void DisableAction()
    {
        animator.SetBool("Walking", false);
        controller.enabled = false;
        attack.enabled = false;
        movement.enabled = false;
    }
    [ContextMenu("enable")]
    public void EnableAction()
    {
        controller.enabled = true;
        attack.enabled = true;
        movement.enabled = true;
    }
}
