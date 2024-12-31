using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerAttackTest : MonoBehaviour
{
    public float lastAttackTime = 0;
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
