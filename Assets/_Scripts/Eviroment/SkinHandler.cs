using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SkinHandler : ObjectPushing
{
    private void OnEnable()
    {
        var targetPos = this.transform.position + new Vector3(0, -2, 0);
        PerformJumping(targetPos);
    }
}
