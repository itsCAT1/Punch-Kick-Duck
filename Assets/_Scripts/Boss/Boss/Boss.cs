using FSMC.Runtime;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Boss : Singleton<Boss>
{
    [HideInInspector]
    public Animator animator;
    [HideInInspector]
    public Rigidbody rigid;
    [HideInInspector]
    public BossAttackType attackType;
    [HideInInspector]
    public BossController controller;
    [HideInInspector]
    public BossHealth health;
    [HideInInspector]
    public BossMovement movement;
    [HideInInspector]
    public BossAttacking attack;
    [HideInInspector]
    public BossPouncing pounce;
    [HideInInspector]
    public BossThrowing throwing;
    [HideInInspector]
    public BossOnBlocking onBlocking;
    [HideInInspector]
    public ForceReceiver receiver;
    [HideInInspector]
    public DroppingCoin coin;
    [HideInInspector]
    public BossReaction reaction;
    [HideInInspector]
    public FSMC_Executer executer;

    void OnValidate()
    {
        animator = GetComponent<Animator>();
        rigid = GetComponent<Rigidbody>();
        attackType = GetComponent<BossAttackType>();
        controller = GetComponent<BossController>();
        health = GetComponent<BossHealth>();
        movement = GetComponent<BossMovement>();
        attack = GetComponent<BossAttacking>();
        pounce = GetComponent<BossPouncing>();
        throwing = GetComponent<BossThrowing>();
        onBlocking = GetComponent<BossOnBlocking>();
        receiver = GetComponent<ForceReceiver>();
        coin = GetComponent<DroppingCoin>();
        reaction = GetComponent<BossReaction>();
        executer = GetComponent<FSMC_Executer>();
    }
}
