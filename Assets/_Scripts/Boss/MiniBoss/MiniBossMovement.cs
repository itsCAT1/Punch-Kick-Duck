using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MiniBossMovement : MonoBehaviour
{
    public float moveSpeed;

    public void PerformMoving()
    {
        var direction = (Player.Instance.transform.position - this.transform.position).normalized;
        this.transform.rotation = Quaternion.LookRotation(direction);

        MiniBoss.Instance.rigid.velocity = direction * moveSpeed;
    }
}
