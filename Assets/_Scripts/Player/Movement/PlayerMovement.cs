using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerMovement : MonoBehaviour
{

    public void PerformMoving()
    {
        var controller = Player.Instance.controller;

        Player.Instance.rigid.velocity = new Vector3(controller.moveSpeed * controller.playerDirection, 0, 0);
    }
}
