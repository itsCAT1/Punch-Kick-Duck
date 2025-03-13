using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerSkinSelector : MonoBehaviour
{
    public GameObject[] skins;

    private void Start()
    {
        SetSkin();
    }

    public void SetSkin()
    {
        var id = DataManager.Instance.data.currentSkin - 1;
        if (id < 0) id = 1;

        for (int i = 0; i < skins.Length; i++)
        {
            skins[i].SetActive(i == id);
            Player.Instance.animator = skins[id].GetComponent<Animator>();
            Player.Instance.dealDamage = skins[id].GetComponent<PlayerDealDamage>();
        }
    }
}
