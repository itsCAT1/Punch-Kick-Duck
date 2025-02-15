﻿using System.Collections;
using System.Collections.Generic;
using Unity.IO.LowLevel.Unsafe;
using UnityEngine;

public class PlayerAttacking : MonoBehaviour
{
    float startTime = 0;
    public float interval = 0.6f;
    public bool timeCoolDown => Time.time - startTime >= interval;

    public bool punchLeft = false;

    public void PerformPunch()
    {
        if (timeCoolDown)
        {
            startTime = Time.time;
            Player.Instance.executer.SetTrigger("Punch");
        }
    }

    public void PerformKick()
    {
        if (timeCoolDown)
        {
            startTime = Time.time;
            Player.Instance.executer.SetTrigger("Kick");
        }
    }

    public void PerformDuck()
    {
        if (timeCoolDown)
        {
            startTime = Time.time;
            Player.Instance.executer.SetTrigger("Duck");
        }
    }
}
