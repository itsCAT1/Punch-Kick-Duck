using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraController : MonoBehaviour
{
    public Vector3 offset;
    public float speedChange;

    void Update()
    {
        SetSpeedFollow();
    }

    void SetSpeedFollow()
    {
        if (ConditionManger.Instance.isStartGame)
        {
            speedChange = 1;
        }

        if (ConditionManger.Instance.isEndGame)
        {
            speedChange = 0.01f;
        }
        FollowPlayer();
    }

    void FollowPlayer()
    {
        var targetPos = new Vector3(Player.Instance.transform.position.x, Player.Instance.transform.position.y + offset.y, offset.z);
        transform.position = Vector3.Lerp(transform.position, targetPos, speedChange);
    }
}
