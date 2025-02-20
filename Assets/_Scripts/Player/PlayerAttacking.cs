using System.Collections;
using System.Collections.Generic;
using Unity.IO.LowLevel.Unsafe;
using UnityEngine;

public class PlayerAttacking : MonoBehaviour
{
    float startTime = 0;
    public float interval = 0.3f;
    public bool timeCoolDown => Time.time - startTime >= interval;

    public bool punchLeft = false;

    private void Update()
    {
        if (Input.GetKeyDown(KeyCode.Q))
        {
            PerformPunch();
            Player.Instance.controller.ChangeDirection(-1);
        }
        if (Input.GetKeyDown(KeyCode.A))
        {
            PerformKick();
            Player.Instance.controller.ChangeDirection(-1);
        }
        if (Input.GetKeyDown(KeyCode.Z))
        {
            PerformDuck();
            Player.Instance.controller.ChangeDirection(-1);
        }

        if (Input.GetKeyDown(KeyCode.O))
        {
            PerformPunch();
            Player.Instance.controller.ChangeDirection(1);
        }
        if (Input.GetKeyDown(KeyCode.K))
        {
            PerformKick();
            Player.Instance.controller.ChangeDirection(1);
        }
        if (Input.GetKeyDown(KeyCode.M))
        {
            PerformDuck();
            Player.Instance.controller.ChangeDirection(1);
        }
    }


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
