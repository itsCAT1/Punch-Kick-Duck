using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PooledObject : MonoBehaviour
{
    private ObjectPool _pool;
    public ObjectPool Pool
    {
        get => _pool;
        set => _pool = value;
    }

    public void Release()
    {

    }
}
