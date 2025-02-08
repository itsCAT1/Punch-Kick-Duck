using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PushingText : MonoBehaviour
{
    Rigidbody rigid;
    public float forcePush;

    void Start()
    {
        this.rigid = GetComponent<Rigidbody>();
    }

    public void PerformPushing()
    {
        rigid.AddForce(new Vector3(Player.Instance.controller.playerDirection * 5, 2, 2) * forcePush);
    }
}
