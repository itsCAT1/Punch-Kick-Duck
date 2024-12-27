using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerAttack : MonoBehaviour
{
    public float punchCoolDown = 0.5f;
    public float resetPunchTime = 1f;
    public float lastPunchTime = 0;
    public bool isPunching = false;
    public bool punchLeft = true;

    public void PerformPunch(int attackDirection)
    {
        if (Time.time - lastPunchTime > resetPunchTime)
        {
            punchLeft = true;
        }

        if (!isPunching)
        {
            Player.Instance.controller.facingDirection = attackDirection;
            isPunching = true;
            if (punchLeft)
            {
                Player.Instance.controller.anim.Play("PunchLeft");
            }
            else
            {
                Player.Instance.controller.anim.Play("PunchRight");
            }

            punchLeft = !punchLeft;

            lastPunchTime = Time.time;

            Invoke("ResetPunching", punchCoolDown);
        }
    }

    private void ResetPunching()
    {
        isPunching = false;
    }

    public void PerformKick(int attackDirection)
    {
        Player.Instance.controller.facingDirection = attackDirection;
        Player.Instance.controller.anim.Play("Kick");
    }

    public void PerformDuck(int attackDirection)
    {
        Player.Instance.controller.facingDirection = attackDirection;
        Player.Instance.controller.anim.Play("Duck");
    }
}
