using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerBlocking : ObjectMoving
{
    public void PlayerIsRepelled()
    {
        var targetPos = Player.Instance.transform.position.x - Player.Instance.transform.localScale.z * pushForce;
        PerformMoving(targetPos);
    }
}
