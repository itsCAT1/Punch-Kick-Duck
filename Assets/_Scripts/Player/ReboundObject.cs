using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ReboundObject : MonoBehaviour
{
    public GameObject[] zonies;

    int index;

    public void StartRebound(int indexZone)
    {
        index = indexZone;

        zonies[index].SetActive(true);

        CancelInvoke(nameof(StopRebound));
        Invoke(nameof(StopRebound), 0.3f);
    }



    void StopRebound()
    {
        zonies[index].SetActive(false);
    }
}
