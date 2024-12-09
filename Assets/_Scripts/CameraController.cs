using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraController : MonoBehaviour
{
    public Transform playerPos;
    public Vector3 offset;
    public float speedChange;

    void Update()
    {
        FollowPlayer();
    }

    void FollowPlayer()
    {
        var targetPos = playerPos.position + offset;
        transform.position = Vector3.Lerp(transform.position, targetPos, speedChange);
    }
}
