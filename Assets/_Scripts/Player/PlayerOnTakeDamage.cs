using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerOnTakeDamage : MonoBehaviour
{
    Rigidbody rigid;
    public Vector3 offset;
    public float speed;

    private void Start()
    {
        rigid = GetComponent<Rigidbody>();
    }

    public void PlayerIsPushed(float direction)
    {
        this.rigid.velocity = Vector3.zero;
        rigid.AddForce(new Vector3(offset.x * direction, offset.y, offset.z), ForceMode.VelocityChange);
    }
}
