using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerIsPushed : ObjectMoving
{
    public void PlayerIsRepelled()
    {
        float signY = Mathf.Sign(this.transform.rotation.y);
        var targetPos = Player.Instance.transform.position.x - signY * pushForce;
        PerformMoving(targetPos);
    }
}
