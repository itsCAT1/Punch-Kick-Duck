using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerSkinSelector : MonoBehaviour
{
    public int index = 0;

    public GameObject[] skins;

    private void Start()
    {
        SetSkin();
    }

    private void Update()
    {
        if (Input.GetKeyDown(KeyCode.Alpha1))
        {
            index = 0;
            SetSkin();
        }
        if (Input.GetKeyDown(KeyCode.Alpha2))
        {
            index = 1;
            SetSkin();
        }
        if (Input.GetKeyDown(KeyCode.Alpha3))
        {
            index = 2;
            SetSkin();
        }
        if (Input.GetKeyDown(KeyCode.Alpha4))
        {
            index = 3;
            SetSkin();
        }
    }

    public void SetSkin()
    {
        for (int i = 0; i < skins.Length; i++)
        {
            skins[i].SetActive(i == index);
            Player.Instance.animator = skins[index].GetComponent<Animator>();
            Player.Instance.dealDamage = skins[index].GetComponent<PlayerDealDamage>();
        }
    }
}
