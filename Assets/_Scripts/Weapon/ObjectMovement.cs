using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ObjectMovement : MonoBehaviour
{
    Rigidbody rigid;
    public float forceSpeed;

    private void Start()
    {
        rigid = GetComponent<Rigidbody>();
    }

    private void Update()
    {
        PushObject();
    }

    void PushObject()
    {
        this.transform.position += this.transform.forward * forceSpeed * Time.deltaTime;
    }

    
}
