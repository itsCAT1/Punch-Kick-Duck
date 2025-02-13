using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyIsPushed : ObjectMoving
{
    public void EnemyIsRepelled()
    {
        float signX = Mathf.Sign(transform.forward.x);
        var targetPos = this.transform.position.x - signX * pushForce;
        PerformMoving(targetPos);
    }
}
