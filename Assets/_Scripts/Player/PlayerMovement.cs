using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerMovement : MonoBehaviour
{

    public void PerformMoving()
    {
        var controller = Player.Instance.controller;

        controller.rigid.velocity = new Vector3(controller.moveSpeed * controller.playerDirection, controller.rigid.velocity.y, controller.rigid.velocity.z);
    }
}
