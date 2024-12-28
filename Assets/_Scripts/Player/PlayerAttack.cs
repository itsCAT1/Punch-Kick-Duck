using System.Collections;
using System.Collections.Generic;
using Unity.IO.LowLevel.Unsafe;
using UnityEngine;



public class PlayerAttack : MonoBehaviour
{
    public float punchCoolDown = 0.5f;
    public float resetPunchTime = 1f;
    public float lastPunchTime = 0;
    public bool isPunching = false;
    public bool punchLeft = true;

    public float interval = 0.5f;
    public bool attackCoolDown => Time.time - lastPunchTime >= interval;

    public void PerformPunch()
    {
        if (Time.time - lastPunchTime > resetPunchTime)
        {
            punchLeft = true;
        }

        if (!isPunching)
        {
            isPunching = true;
            if (punchLeft)
            {
                Player.Instance.controller.animator.Play("PunchLeft");
            }
            else
            {
                Player.Instance.controller.animator.Play("PunchRight");
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

    public void PerformKick()
    {
        
        if (attackCoolDown)
        {
            Player.Instance.stateManager.ChangeState(new KickState());
            lastPunchTime = Time.time;
        }
    }

    public void PerformDuck()
    {
        if (attackCoolDown)
        {
            Player.Instance.stateManager.ChangeState(new DuckState());
            lastPunchTime = Time.time;
        }
    }
}
