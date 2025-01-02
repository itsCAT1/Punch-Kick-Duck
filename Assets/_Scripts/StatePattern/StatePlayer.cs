using System.Collections;
using System.Collections.Generic;
using Unity.IO.LowLevel.Unsafe;
using UnityEngine;


public class PlayerIdleState : IState
{

    public void Enter()
    {
        Player.Instance.controller.moveSpeed = 2;
        Player.Instance.controller.animator.Play("Idle");
    }

    public void Execute()
    {

    }

    public void Exit()
    {

    }
}

public class PlayerWalkState : IState
{

    public void Enter()
    {
        Player.Instance.controller.moveSpeed = 2;
        Player.Instance.controller.facingDirection = 1;
        Player.Instance.controller.animator.Play("Walk");
    }

    public void Execute()
    {
        
    }

    public void Exit()
    {
        
    }
}

public class PlayerPunchState : IState
{
    private float timeStart = 0;
    private bool resetState => Time.time - timeStart >= 1f;
    private bool changeStateTime => Time.time - timeStart >= 2f;
    public void Enter()
    {
        Player.Instance.controller.moveSpeed = 2;

        OnPerformPunch();
    }

    void OnPerformPunch()
    {
        if (Player.Instance.performAttack.punchLeft)
        {
            Player.Instance.controller.animator.SetTrigger("PunchLeft");
        }
        else
        {
            Player.Instance.controller.animator.SetTrigger("PunchRight");
        }

        Player.Instance.performAttack.punchLeft = !Player.Instance.performAttack.punchLeft;
        timeStart = Time.time;
    }

    public void Execute()
    {
        if (resetState) Player.Instance.performAttack.punchLeft = true;
        if (changeStateTime) Player.Instance.stateManager.ChangeState(new PlayerWalkState());
    }

    public void Exit()
    {
        
    }
}

public class PlayerKickState : IState
{
    private float timeStart = 0;
    public bool changeStateTime => Time.time - timeStart >= 2f;


    public void Enter()
    {
        Player.Instance.controller.moveSpeed = 2;
        Player.Instance.controller.animator.SetTrigger("Kick");
        timeStart = Time.time;
    }

    public void Execute()
    {
        if (changeStateTime) Player.Instance.stateManager.ChangeState(new PlayerWalkState());
    }

    public void Exit()
    {

    }
}

public class PlayerDuckState : IState
{
    private float timeStart = 0;
    public bool changeStateTime => Time.time - timeStart >= 2f;


    public void Enter()
    {
        Player.Instance.controller.moveSpeed = 2;
        Player.Instance.controller.animator.SetTrigger("Duck");
        timeStart = Time.time;
    }

    public void Execute()
    {
        if (changeStateTime) Player.Instance.stateManager.ChangeState(new PlayerWalkState());
    }

    public void Exit()
    {

    }
}

public class PlayerHurtState : IState
{
    private float timeStart = 0;
    public bool changeStateTime => Time.time - timeStart >= 2f;


    public void Enter()
    {
        Player.Instance.controller.moveSpeed = 2;
        Player.Instance.controller.animator.Play("Hurt");
        timeStart = Time.time;
    }

    public void Execute()
    {
        if (changeStateTime) Player.Instance.stateManager.ChangeState(new PlayerWalkState());
    }

    public void Exit()
    {

    }
}


