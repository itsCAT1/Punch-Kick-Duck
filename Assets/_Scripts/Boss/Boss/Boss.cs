using FSMC.Runtime;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Boss : Singleton<Boss>
{
    [HideInInspector]
    public Animator animator;
    [HideInInspector]
    public BossAttackType attackType;
    [HideInInspector]
    public BossController controller;
    [HideInInspector]
    public BossMovement movement;
    [HideInInspector]
    public BossAttacking attack;
    [HideInInspector]
    public BossPouncing pounce;
    [HideInInspector]
    public BossThrowing throwing;
    [HideInInspector]
    public FSMC_Executer executer;

    void OnValidate()
    {
        animator = GetComponent<Animator>();
        attackType = GetComponent<BossAttackType>();
        controller = GetComponent<BossController>();
        movement = GetComponent<BossMovement>();
        attack = GetComponent<BossAttacking>();
        pounce = GetComponent<BossPouncing>();
        throwing = GetComponent<BossThrowing>();
        executer = GetComponent<FSMC_Executer>();
    }
}
