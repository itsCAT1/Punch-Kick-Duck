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
        var targetPos = playerPos.transform.position + offset;
        transform.position = Vector3.Lerp(transform.position, targetPos, speedChange);
    }
}
