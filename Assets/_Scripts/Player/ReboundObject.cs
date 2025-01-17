using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ReboundObject : MonoBehaviour
{
    public GameObject[] zonies;

    public void EnableRebound(int indexZone)
    {
        Debug.Log("enable");
        zonies[indexZone].SetActive(true);
    }

    public void DisableRebound(int indexZone)
    {

        zonies[indexZone].SetActive(false);
    }
}
