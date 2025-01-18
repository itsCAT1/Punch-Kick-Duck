using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyBeaten : ObjectJumping
{
    public Vector3 offset;
    Rigidbody rigid;

    EnemyActionManager enemyActionManager;

    private void Start()
    {
        rigid = GetComponent<Rigidbody>();
        enemyActionManager =GetComponent<EnemyActionManager>();
    }

    public void EnemyIsBeaten()
    {
        enemyActionManager.DisableAction();
        rigid.isKinematic = false;

        float signX = Mathf.Sign(transform.forward.x);
        var targetPos = this.transform.position + new Vector3(offset.x * signX, offset.y, offset.z);
        PerformJumping(targetPos);
    }
}
