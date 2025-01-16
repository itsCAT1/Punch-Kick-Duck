using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ThrowObject : MonoBehaviour
{
    Rigidbody rigid;
    public Transform rotatePos;
    public float forceSpeed;
    public float rotateSpeed;

    private void Start()
    {
        rigid = GetComponent<Rigidbody>();
    }

    void FixedUpdate()
    {
        RotateObject();
    }

    private void Update()
    {
        if(Input.GetKeyDown(KeyCode.Space))
        {
            PushObject();
        }
        if (Input.GetKeyDown(KeyCode.E))
        {
            ReflectObject();
        }
    }

    void PushObject()
    {
        rigid.velocity = this.transform.right * forceSpeed;
    }

    void ReflectObject()
    {
        this.transform.rotation = Quaternion.Euler(0, 180, 0);
    }

    void RotateObject()
    {
        Quaternion rotate = rotatePos.transform.rotation;
        float angle = rotate.eulerAngles.z + rotateSpeed;
        rotate.eulerAngles = new Vector3(rotate.x, rotate.y, angle);
        rotatePos.transform.rotation = rotate;
    }
}
