using DG.Tweening;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BossPouncing : ObjectPushing
{
    public Transform foodCart;
    public Transform[] pouncePosition;
    public float distance;
    
    void Update()
    {
        
    }



    public void Pounce()
    {
        Boss.Instance.animator.Play("Pounces");

    }

    public void PerformPounce()
    {
        var signX = Mathf.Sign(this.transform.rotation.y);
        Debug.Log(signX);
        var jumpTarget = this.transform.position + new Vector3(distance * signX, 0, 0);

        PerformJumping(jumpTarget);
    }

    public void MoveTowardCart()
    {
        if(this.transform.position.x > foodCart.position.x)
        {
            this.transform.DOMoveX(pouncePosition[0].position.x, 0.5f);
        }
        else
        {
            this.transform.DOMoveX(pouncePosition[1].position.x, 0.5f);
        }
    }

}
