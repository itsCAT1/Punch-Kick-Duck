using FSMC.Runtime;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MiniBoss : Singleton<MiniBoss>
{
    [HideInInspector]
    public MiniBossController controller;
    [HideInInspector]
    public MiniBossAttack attack;
    [HideInInspector]
    public MiniBossMovement movement;
    [HideInInspector]
    public MiniBossReaction reaction;
    [HideInInspector]
    public Animator animator;
    [HideInInspector]
    public Rigidbody rigid;
    [HideInInspector]
    public FSMC_Executer executer;

    private void OnValidate()
    {
        controller = GetComponent<MiniBossController>();
        attack = GetComponent<MiniBossAttack>();
        movement = GetComponent<MiniBossMovement>();
        reaction = GetComponent<MiniBossReaction>();
        animator = GetComponent<Animator>();
        rigid = GetComponent<Rigidbody>();
        executer = GetComponent<FSMC_Executer>();
    }
}
