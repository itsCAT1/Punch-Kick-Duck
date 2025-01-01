using System.Collections;
using System.Collections.Generic;
using Unity.IO.LowLevel.Unsafe;
using UnityEngine;


public class EnemyIdleState : IState
{
    public EnemyController controller;

    public EnemyIdleState(EnemyController controller)
    {
        this.controller = controller;
    }

    public void Enter()
    {
        controller.animator.Play("Idle");
    }

    public void Execute()
    {

    }

    public void Exit()
    {

    }
}

public class EnemyWalkState : IState
{
    public EnemyController controller;

    public EnemyWalkState(EnemyController controller)
    {
        this.controller = controller;
    }

    public void Enter()
    {
        controller.animator.Play("Walk");
    }

    public void Execute()
    {
        
    }

    public void Exit()
    {
        
    }
}

public class EnemyPunchState : IState
{
    public EnemyController controller;

    public EnemyPunchState(EnemyController controller)
    {
        this.controller = controller;
    }

    public void Enter()
    {
        OnPerformPunch();
    }

    void OnPerformPunch()
    {
        controller.animator.Play("PunchRight");
    }

    public void Execute()
    {
        
    }

    public void Exit()
    {
        
    }
}

public class EnemyKickState : IState
{
    public EnemyController controller;

    public EnemyKickState(EnemyController controller)
    {
        this.controller = controller;
    }


    public void Enter()
    {
        controller.animator.Play("Kick");
    }

    public void Execute()
    {
        
    }

    public void Exit()
    {

    }
}

public class EnemyDuckState : IState
{
    public EnemyController controller;

    public EnemyDuckState(EnemyController controller)
    {
        this.controller = controller;
    }


    public void Enter()
    {
        controller.animator.Play("Duck");
    }

    public void Execute()
    {
        
    }

    public void Exit()
    {

    }
}


