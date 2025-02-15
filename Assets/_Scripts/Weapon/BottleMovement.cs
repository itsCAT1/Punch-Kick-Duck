using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BottleMovement : MonoBehaviour
{
    Rigidbody rigid;
    public float forceSpeed;

    private void Update()
    {
        PushObject();
    }

    void PushObject()
    {
        this.transform.position += this.transform.forward * forceSpeed * Time.deltaTime;
    }

    
}
