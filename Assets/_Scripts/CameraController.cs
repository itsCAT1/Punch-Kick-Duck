using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraController : MonoBehaviour
{
    public Vector3 offset;
    public float speedChange;

    public Transform playerPos;

    void Update()
    {
        FollowPlayer();
    }

    void FollowPlayer()
    {
        var targetPos = new Vector3(playerPos.transform.position.x, offset.y, offset.z);
        transform.position = Vector3.Lerp(transform.position, targetPos, speedChange);
    }
}
