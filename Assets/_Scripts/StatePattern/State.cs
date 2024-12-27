using System.Collections;
using System.Collections.Generic;
using UnityEngine;


public class WalkState : IState
{

    public void Enter()
    {
        Player.Instance.controller.moveSpeed = 5f;
        Player.Instance.controller.anim.Play("Walk"); 
    }

    public void Execute()
    {
        
    }

    public void Exit()
    {
        // Có thể thêm logic khi thoát trạng thái
    }
}

public class AttackState : IState
{

    public void Enter()
    {
        Player.Instance.controller.moveSpeed = 5f;
        Player.Instance.controller.anim.Play("Attack"); 
    }

    public void Execute()
    {
        // Có thể thêm logic nếu cần thực hiện liên tục trong trạng thái tấn công
    }

    public void Exit()
    {
        // Có thể thêm logic khi thoát trạng thái
    }
}


