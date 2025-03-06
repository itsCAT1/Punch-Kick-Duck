using FSMC.Runtime;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Bee : MonoBehaviour
{
    [HideInInspector]
    public Rigidbody rigid;
    [HideInInspector]
    public Animator animator;
    [HideInInspector]
    public BeeController controller;
    [HideInInspector]
    public BeeMovement movement;
    [HideInInspector]
    public BeeAttack attack;
    [HideInInspector]
    public BeeBeaten beaten;
    [HideInInspector]
    public BeeReaction reaction;
    [HideInInspector]
    public FSMC_Executer executer;

    void OnValidate()
    {
        rigid = GetComponent<Rigidbody>();
        animator = GetComponent<Animator>();
        controller = GetComponent<BeeController>();
        movement = GetComponent<BeeMovement>();
        attack = GetComponent<BeeAttack>();
        beaten = GetComponent<BeeBeaten>();
        reaction = GetComponent<BeeReaction>();
        executer = GetComponent<FSMC_Executer>();
    }
}
