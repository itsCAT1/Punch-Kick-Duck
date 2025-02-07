using RMC.Core.UEvents;
using RMC.Core.UEvents.UEventDispatcher;
using System.Collections;
using System.Collections.Generic;
using UnityEditor.Experimental.GraphView;
using UnityEngine;

public class PushingPlayer : MonoBehaviour
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
        rigid.AddForce(new Vector3(offset.x * direction, offset.y, offset.z), ForceMode.VelocityChange);
    }

    
}
