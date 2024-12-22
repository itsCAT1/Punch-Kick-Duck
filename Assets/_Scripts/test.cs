using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class test : MonoBehaviour
{
    private int _number = 100;

    public int Number
    {
        get => _number;
        set
        {
            _number = value;
        }
    }

    private void Start()
    {
        Debug.Log("Truoc: " + _number);
        Number += 50;
        Debug.Log("Sau: " + _number);
    }
}


