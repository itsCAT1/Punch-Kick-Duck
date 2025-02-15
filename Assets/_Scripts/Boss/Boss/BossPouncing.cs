using DG.Tweening;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BossPouncing : ObjectPushing
{
    public Vector3 foodCart;

    public Vector3 targetPos;
    public Transform[] pouncePosition;

    public float speedMove;
    
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
        var jumpTarget = this.transform.position + new Vector3(15 * signX, 0, 0);

        PerformJumping(jumpTarget);
    }

    public void SetTarget()
    {
        if (this.transform.position.x > foodCart.x)
        {
            targetPos = foodCart + new Vector3(-2, 0, 0);
        }
        else
        {
            targetPos = foodCart + new Vector3(2, 0, 0);
        }
    }

    public void PerformMoving()
    {
        this.transform.position = Vector3.MoveTowards(this.transform.position, targetPos, speedMove * Time.deltaTime);
    }

    public void PerformRotate(Transform target)
    {
        var direction = target.position - this.transform.position;
        this.transform.rotation = Quaternion.LookRotation(direction);

    }
}
