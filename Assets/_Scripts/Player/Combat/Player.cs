using FSMC.Runtime;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Player : Singleton<Player>
{
    public Animator animator;
    public PlayerDealDamage dealDamage;

    [HideInInspector]
    public PlayerController controller;
    [HideInInspector]
    public Rigidbody rigid;
    [HideInInspector]
    public PlayerAttackType attackType;
    [HideInInspector]
    public PlayerDetecter detecter;
    [HideInInspector]
    public PlayerAttacking attack;
    [HideInInspector]
    public PlayerMovement movement;
    [HideInInspector]
    public PlayerHealth health;
    [HideInInspector]
    public ForceReceiver receiver;
    [HideInInspector]
    public PushHandler push;
    [HideInInspector]
    public PlayerOnBlocking block;
    [HideInInspector]
    public PlayerBossFollower followBoss;
    [HideInInspector]
    public PlayerSkinSelector selecter;
    [HideInInspector]
    public PlayerOnTutorial tutorial;

    [HideInInspector]
    public FSMC_Executer executer;
    private void OnValidate()
    {
        controller = GetComponent<PlayerController>();
        rigid = GetComponent<Rigidbody>();
        attackType = GetComponent<PlayerAttackType>();
        detecter = GetComponent<PlayerDetecter>();
        attack = GetComponent<PlayerAttacking>();
        movement = GetComponent<PlayerMovement>();
        health = GetComponent<PlayerHealth>();
        receiver = GetComponent<ForceReceiver>();
        push = GetComponent<PushHandler>();
        block = GetComponent<PlayerOnBlocking>();
        followBoss = GetComponent<PlayerBossFollower>();
        selecter = GetComponent<PlayerSkinSelector>();
        tutorial = GetComponent<PlayerOnTutorial>();
        executer = GetComponent<FSMC_Executer>();
    }
}
