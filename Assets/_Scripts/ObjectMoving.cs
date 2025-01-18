using DG.Tweening;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ObjectMoving : MonoBehaviour
{
    public float pushForce;
    public float duration;

    public void PerformMoving(float targetPosition)
    {
        transform.DOMoveX(targetPosition, duration);
    }
}
