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
    private float lastAttackTime;
    private bool resetState => Time.time - lastAttackTime >= 1f;
    private bool changeStateTime => Time.time - lastAttackTime >= 2f;
    public void Enter()
    {
        Player.Instance.controller.moveSpeed = 2;

        OnPerformPunch();
    }

    void OnPerformPunch()
    {
        if (Player.Instance.performAttack.punchLeft)
        {
            Player.Instance.controller.animator.Play("PunchLeft");
        }
        else
        {
            Player.Instance.controller.animator.Play("PunchRight");
        }

        Player.Instance.performAttack.punchLeft = !Player.Instance.performAttack.punchLeft;
        lastAttackTime = Time.time;
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
    private float lastAttackTime;
    public bool attackCoolDown => Time.time - lastAttackTime >= 0.5f;
    public bool changeStateTime => Time.time - lastAttackTime >= 2f;


    public void Enter()
    {
        Player.Instance.controller.moveSpeed = 2;
        Player.Instance.controller.animator.Play("Kick");
        lastAttackTime = Time.time;
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
    private float lastAttackTime;
    public bool attackCoolDown => Time.time - lastAttackTime >= 0.5f;
    public bool changeStateTime => Time.time - lastAttackTime >= 2f;


    public void Enter()
    {
        Player.Instance.controller.moveSpeed = 2;
        Player.Instance.controller.animator.Play("Duck");
        lastAttackTime = Time.time;
    }

    public void Execute()
    {
        if (changeStateTime) Player.Instance.stateManager.ChangeState(new PlayerWalkState());
    }

    public void Exit()
    {

    }
}


