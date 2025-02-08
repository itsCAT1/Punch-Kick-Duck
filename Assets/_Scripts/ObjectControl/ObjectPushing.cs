using DG.Tweening;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ObjectPushing : MonoBehaviour
{
    public float pushForce;
    public float duration;


    public void PerformJumping(Vector3 targetPosition)
    {
        transform.DOJump(targetPosition, pushForce, 1, duration);
    }
}
