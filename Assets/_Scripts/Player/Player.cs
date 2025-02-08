using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Player : Singleton<Player>
{
    public PlayerController controller;
    public PlayerAttackType attackType;
    public PlayerAttack attack;
    public PlayerHealth health;
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
