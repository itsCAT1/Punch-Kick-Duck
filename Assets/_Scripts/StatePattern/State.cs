using System.Collections;
using System.Collections.Generic;
using Unity.IO.LowLevel.Unsafe;
using UnityEngine;


public class WalkState : IState
{

    public void Enter()
    {
        Player.Instance.controller.moveSpeed = 2;
        Player.Instance.controller.facingDirection = 1;
    }

    public void Execute()
    {
        
    }

    public void Exit()
    {
        
    }
}

public class PunchState : IState
{

    public void Enter()
    {
        Player.Instance.controller.moveSpeed = 0;
    }

    public void Execute()
    {
        
    }

    public void Exit()
    {
        
    }
}

public class KickState : IState
{
    public float interval = 1;
    private float lastKickTime = 0;
    public bool attackCoolDown => Time.time - lastKickTime >= interval;

    public void Enter()
    {
        Player.Instance.controller.animator.Play("Kick");
    }

    public void Execute()
    {
        if(attackCoolDown) Player.Instance.stateManager.ChangeState(new WalkState());
    }

    public void Exit()
    {

    }
}

public class DuckState : IState
{
    public float interval = 1;
    private float lastKickTime = 0;
    public bool attackCoolDown => Time.time - lastKickTime >= interval;

    public void Enter()
    {
        Player.Instance.controller.animator.Play("Duck");
    }

    public void Execute()
    {
        if (attackCoolDown) Player.Instance.stateManager.ChangeState(new WalkState());
    }

    public void Exit()
    {

    }
}


