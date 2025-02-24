using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class CharacterSelectionHandler : MonoBehaviour
{
    public GameObject[] box;
    public GameObject[] play;
    public TextMeshProUGUI skinQuantity;
    public TextMeshProUGUI currentCoin;


    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        UpdateUI();
    }

    void UpdateUI()
    {
        skinQuantity.text = "COLLECTION:  " + SkinManager.Instance.listSkinOwned.list.Count.ToString() + " / 4";
        currentCoin.text = DataManager.Instance.data.totalCoin.ToString();

        CheckCurrentSkin();
    }

    void CheckCurrentSkin()
    {
        var skinIndex = CameraManager.Instance.skinSelector.currentIndex;

        if (!SkinManager.Instance.CheckSkin(skinIndex))
        {
            for (int i = 0; i < box.Length; i++)
            {
                box[i].SetActive(i == skinIndex);
                play[i].SetActive(false);
            }
        }

        else
        {
            for (int i = 0; i < box.Length; i++)
            {
                play[i].SetActive(i == skinIndex);
            }
        }

        DataManager.Instance.data.currentSkin = skinIndex;
    }

    public void SelectRandom()
    {
        List<SkinOwned> ownedSkins = SkinManager.Instance.listSkinOwned.list;

        int randomIndex = Random.Range(0, ownedSkins.Count);
        int selectedSkinIndex = ownedSkins[randomIndex].indexSkin;

        DataManager.Instance.data.currentSkin = selectedSkinIndex;

        CheckCurrentSkin();
    }
}
