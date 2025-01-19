using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyActionManager : MonoBehaviour
{
    EnemyController controller;
    EnemyMovement movement;
    EnemyAttack attack;

    private void Start()
    {
        controller = GetComponent<EnemyController>();
        attack = GetComponent<EnemyAttack>();
        movement = GetComponent<EnemyMovement>();
    }

    public void DisableAction()
    {
        controller.enabled = false;
        movement.enabled = false;
        attack.enabled = false;
    }

    public void EnableAction()
    {
        controller.enabled = true;
        movement.enabled = true;
        attack.enabled = true;
    }
}
