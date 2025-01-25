using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Player : Singleton<Player>
{
    public PlayerController controller;
    public PlayerAttackType attackType;
    public PlayerAttack attack;
    public PlayerHealth health;
    public PushingPlayer push;
}
