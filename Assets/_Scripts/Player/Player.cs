using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Player : Singleton<Player>
{
    [HideInInspector]
    public PlayerController controller;
    [HideInInspector]
    public PlayerAttackType attackType;
    [HideInInspector]
    public PlayerAttack attack;
    [HideInInspector]
    public PlayerHealth health;
    [HideInInspector]
    public PlayerOnTakeDamage onTakeDamage;

    private void OnValidate()
    {
        controller = GetComponent<PlayerController>();
        attackType = GetComponent<PlayerAttackType>();
        attack = GetComponent<PlayerAttack>();
        health = GetComponent<PlayerHealth>();
        onTakeDamage = GetComponent<PlayerOnTakeDamage>();
    }
}
