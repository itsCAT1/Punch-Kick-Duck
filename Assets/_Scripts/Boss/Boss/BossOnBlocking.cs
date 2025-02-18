using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BossOnBlocking : EnemyOnBlocking
{
    public void BlockDamage()
    {
        if (Boss.Instance.attackType.type == AttackType.Punch)
        {
            Boss.Instance.animator.Play("BlockPunch");
        }

        else if (Boss.Instance.attackType.type == AttackType.Kick)
        {
            Boss.Instance.animator.Play("BlockKick");
        }

        else if (Boss.Instance.attackType.type == AttackType.Duck)
        {
            Boss.Instance.animator.Play("BlockDuck");
        }
    }
}
