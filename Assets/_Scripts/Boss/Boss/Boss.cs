using FSMC.Runtime;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Boss : Singleton<Boss>
{
    public BossController controller;
    public BossMovement movement;
    public BossAttackType attackType;
    public BossPouncing pounce;
    public Animator animator;
    public FSMC_Executer executer;

    void OnValidate()
    {
        controller = GetComponent<BossController>();
        movement = GetComponent<BossMovement>();
        attackType = GetComponent<BossAttackType>();
        pounce = GetComponent<BossPouncing>();
        animator = GetComponent<Animator>();
        executer = GetComponent<FSMC_Executer>();
    }
}
