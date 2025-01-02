using System.Collections;
using System.Collections.Generic;
using Unity.IO.LowLevel.Unsafe;
using UnityEngine;

public class PlayerAttack : MonoBehaviour
{
    float startTime = 0;
    public float interval = 0.5f;
    public bool timeCoolDown => Time.time - startTime >= interval;

    public bool punchLeft = false;
    public void PerformPunch()
    {
        if (timeCoolDown)
        {
            startTime = Time.time;
            Player.Instance.stateManager.ChangeState(new PlayerPunchState());
        }
    }

    public void PerformKick()
    {
        if (timeCoolDown)
        {
            startTime = Time.time;
            Player.Instance.stateManager.ChangeState(new PlayerKickState());
        }
    }

    public void PerformDuck()
    {
        if (timeCoolDown)
        {
            startTime = Time.time;
            Player.Instance.stateManager.ChangeState(new PlayerDuckState());
        }
    }

    public void PerformHurt()
    {
        if (timeCoolDown)
        {
            startTime = Time.time;
            Player.Instance.stateManager.ChangeState(new PlayerHurtState());
        }
    }
}
