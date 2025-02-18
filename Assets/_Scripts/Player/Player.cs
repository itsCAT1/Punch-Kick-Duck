using FSMC.Runtime;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Player : Singleton<Player>
{
    public Animator animator;
    [HideInInspector]
    public PlayerController controller;
    [HideInInspector]
    public Rigidbody rigid;
    [HideInInspector]
    public PlayerAttackType attackType;
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
    public FSMC_Executer executer;
    private void OnValidate()
    {
        controller = GetComponent<PlayerController>();
        rigid = GetComponent<Rigidbody>();
        attackType = GetComponent<PlayerAttackType>();
        attack = GetComponent<PlayerAttacking>();
        movement = GetComponent<PlayerMovement>();
        health = GetComponent<PlayerHealth>();
        receiver = GetComponent<ForceReceiver>();
        push = GetComponent<PushHandler>();
        block = GetComponent<PlayerOnBlocking>();
        executer = GetComponent<FSMC_Executer>();
    }
}
