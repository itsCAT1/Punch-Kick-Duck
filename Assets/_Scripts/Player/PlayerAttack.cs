using System.Collections;
using System.Collections.Generic;
using Unity.IO.LowLevel.Unsafe;
using UnityEngine;

public class PlayerAttack : MonoBehaviour
{
    public float punchCoolDown = 0.5f;
    public float resetPunchTime = 1f;
    public float lastAttackTime = 0;
    public bool isPunching = false;
    public bool punchLeft = true;

    public float interval = 0.5f;
    public bool attackCoolDown => Time.time - lastAttackTime >= interval;

    public void PerformPunch()
    {
        if (attackCoolDown)
        {
            lastAttackTime = Time.time;
            Player.Instance.stateManager.ChangeState(new PunchState());
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
            lastAttackTime = Time.time;
            Player.Instance.stateManager.ChangeState(new KickState());
        }
    }

    public void PerformDuck()
    {
        if (attackCoolDown)
        {
            lastAttackTime = Time.time;
            Player.Instance.stateManager.ChangeState(new DuckState());
        }
    }
}
