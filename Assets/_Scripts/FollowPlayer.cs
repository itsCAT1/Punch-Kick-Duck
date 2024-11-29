using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FollowPlayer : MonoBehaviour
{
    public Transform player;
    public float offset;

    void Update()
    {
        var cameraPos = this.transform.position;
        cameraPos = new Vector3(player.transform.position.x, 
            transform.position.y, offset);
        this.transform.position = cameraPos;
    }
}
