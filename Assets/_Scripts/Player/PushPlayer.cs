using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PushPlayer : ObjectJumping
{
    void Update()
    {
        if (Input.GetKeyDown(KeyCode.Space))
        {
            //PlayerIsHurt();
        }
    }

    public void PlayerIsPushed(Vector3 offset)
    {
        var targetPos = this.transform.position + offset;
        PerformJumping(targetPos);
    }
}
