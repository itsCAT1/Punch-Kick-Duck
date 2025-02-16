using DG.Tweening;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BossPouncing : ObjectPushing
{
    public GameObject foodCart;
    public Vector3 targetPos;
    
    void Update()
    {
        if (Input.GetKeyDown(KeyCode.Z))
        {
            Boss.Instance.executer.SetCurrentState("Pounce");
        }

        if (Input.GetKeyDown(KeyCode.B))
        {
            SetTarget();
        }
    }

    public void PerformPounce()
    {
        var signX = Mathf.Sign(this.transform.rotation.y);
        var jumpTarget = this.transform.position + new Vector3(20 * signX, 0, 0);

        PerformJumping(jumpTarget);
    }

    public void SetTarget()
    {
        if (this.transform.position.x > foodCart.transform.position.x)
        {
            targetPos = foodCart.transform.position + new Vector3(-2, 0, 0);
        }
        else
        {
            targetPos = foodCart.transform.position + new Vector3(2, 0, 0);
        }
        RotateTowardCart(targetPos);
    }

    public void RotateTowardCart(Vector3 target)
    {
        var direction = target - this.transform.position;
        this.transform.rotation = Quaternion.LookRotation(direction);
    }

    public void RotateTowardPlayer()
    {
        var direction = Player.Instance.transform.position - this.transform.position;
        this.transform.rotation = Quaternion.LookRotation(direction);
    }
}
