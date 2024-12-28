using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ObjectPool : MonoBehaviour
{
    [SerializeField] private int initPoolSize;
    [SerializeField] private PooledObject objectToPool;

    private List<PooledObject> list;
    void Start()
    {
        
    }

    private void SetupPool()
    {
        list = new List<PooledObject>();
        PooledObject instance = null;

        for(int i = 0; i < initPoolSize; i++)
        {
            instance = Instantiate(objectToPool);
            instance.Pool = this;
            instance.gameObject.SetActive(false);
            list.Add(instance);
        }
    }

    
}
