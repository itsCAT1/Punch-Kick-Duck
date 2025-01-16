using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RotateObject : MonoBehaviour
{
    public Transform rotatePos;
    public float rotateSpeed;

    void FixedUpdate()
    {
        Rotate();
    }

    void Rotate()
    {
        Quaternion rotate = rotatePos.transform.rotation;
        float angle = rotate.eulerAngles.z - rotateSpeed;
        rotate.eulerAngles = new Vector3(rotate.x, rotate.y, angle);
        rotatePos.transform.rotation = rotate;
    }
}
