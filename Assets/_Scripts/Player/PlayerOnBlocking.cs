using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerOnBlocking : ObjectMoving
{
    public void PlayerIsRepelled()
    {
        float signY = Mathf.Sign(this.transform.rotation.y);
        var targetPos = Player.Instance.transform.position.x - signY * pushForce;
        PerformMoving(targetPos);
    }

    public void BlockDamage()
    {
        if (Player.Instance.attackType.type == AttackType.Punch)
        {
            Player.Instance.animator.Play("BlockPunch");
        }

        else if (Player.Instance.attackType.type == AttackType.Kick)
        {
            Player.Instance.animator.Play("BlockKick");
        }

        else if (Player.Instance.attackType.type == AttackType.Duck)
        {
            Player.Instance.animator.Play("BlockDuck");
        }
        PlayerIsRepelled();
    }
}
