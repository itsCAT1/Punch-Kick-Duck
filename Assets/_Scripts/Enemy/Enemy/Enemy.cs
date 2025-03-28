using FSMC.Runtime;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Enemy : MonoBehaviour
{
    [HideInInspector]
    public Rigidbody rigid;
    [HideInInspector]
    public Animator animator;
    [HideInInspector]
    public EnemyController controller;
    [HideInInspector]
    public EnemyAttacking attack;
    [HideInInspector]
    public EnemyMovement movement;
    [HideInInspector]
    public EnemyThrowBottle thowBottle;
    [HideInInspector]
    public EnemyApear apear;
    [HideInInspector]
    public Health health;
    [HideInInspector]
    public DroppingCoin coin;
    [HideInInspector]
    public EnemyOnTutorial tutorial;
    [HideInInspector]
    public FSMC_Executer executer;

    void OnValidate()
    {
        executer = GetComponent<FSMC_Executer>();
        rigid = GetComponent<Rigidbody>();
        animator = GetComponent<Animator>();
        health = GetComponent<Health>();
        controller = GetComponent<EnemyController>();
        movement = GetComponent<EnemyMovement>();
        attack = GetComponent<EnemyAttacking>();
        apear = GetComponent<EnemyApear>();
        coin = GetComponent<DroppingCoin>();
        tutorial = GetComponent<EnemyOnTutorial>();

        if (controller.haveBottle)
        {
            thowBottle = GetComponent<EnemyThrowBottle>();
        }
    }
}
