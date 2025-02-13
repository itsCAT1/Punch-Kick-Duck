using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyBeaten : ObjectPushing
{
    public Vector3 offset;
    Rigidbody rigid;
    DroppingCoin coin;

    private void Start()
    {
        rigid = GetComponent<Rigidbody>();
        coin = GetComponent<DroppingCoin>();
    }

    public void EnemyThrownOut()
    {
        float signX = Mathf.Sign(transform.forward.x);
        var targetPos = this.transform.position + new Vector3(offset.x * signX, offset.y, offset.z);
        PerformJumping(targetPos);
    }
}
