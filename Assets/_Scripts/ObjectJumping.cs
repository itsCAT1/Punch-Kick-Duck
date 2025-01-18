using DG.Tweening;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ObjectJumping : MonoBehaviour
{
    public float jumpForce;
    public float duration;


    public void PerformJumping(Vector3 targetPosition)
    {
        transform.DOJump(targetPosition, jumpForce, 1, duration);
    }
}
