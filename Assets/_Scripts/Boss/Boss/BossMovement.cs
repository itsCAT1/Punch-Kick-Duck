using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BossMovement : MonoBehaviour
{
    public float speedMove;

    public void PerformMoving()
    {
        this.transform.position = Vector3.MoveTowards(this.transform.position, Boss.Instance.pounce.targetPos, speedMove * Time.deltaTime);
    }
}
