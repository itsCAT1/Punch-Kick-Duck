using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BeeBeaten : ObjectPushing
{
    public Vector3 offset;
    Animator animator;
    DroppingCoin coin;

    private void Start()
    {
        animator = GetComponent<Animator>();
        coin = GetComponent<DroppingCoin>();
    }

    public void BeeThrownOut()
    {
        float signX = Mathf.Sign(transform.forward.x);
        var targetPos = this.transform.position + new Vector3(offset.x * signX, offset.y, offset.z);
        PerformJumping(targetPos);

        GainPoint();
        Destroy(this.gameObject, 2);
    }

    void GainPoint()
    {
        animator.enabled = false;
        coin.RandomDropCoin();
        CombatManager.Instance.GainPoint();
    }
}
