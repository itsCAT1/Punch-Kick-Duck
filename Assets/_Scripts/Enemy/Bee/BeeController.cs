using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BeeController : ObjectPushing
{
    public Vector3 offset;

    private void Update()
    {
        if (Input.GetKeyDown(KeyCode.X))
        {
            EnemyIsBeaten();
        }
    }

    public void EnemyIsBeaten()
    {
        var targetPos = this.transform.position + new Vector3(offset.x, offset.y, offset.z);
        PerformJumping(targetPos);
    }
}
