using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SelfDestroy : MonoBehaviour
{
    public float timeDuration;
    private void Start()
    {
        Destroy(gameObject, timeDuration);
    }
}
