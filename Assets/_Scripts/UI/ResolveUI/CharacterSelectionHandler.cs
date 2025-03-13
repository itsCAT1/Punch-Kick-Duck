using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class CharacterSelectionHandler : Singleton<CharacterSelectionHandler>
{
    public GameObject[] buttonUnbox;
    public GameObject[] buttonPlay;
    public GameObject[] skin;
    public GameObject[] box;
    public GameObject nonInteract;

    public TextMeshProUGUI skinQuantity;
    public TextMeshProUGUI currentCoin;
    public List<GameObject> skinOwned;

    private void OnEnable()
    {
        UpdateUI();
        SetSkinOwned();
    }

    public void UpdateUI()
    {
        skinQuantity.text = "COLLECTION:  " + SkinManager.Instance.listSkinOwned.skins.Count.ToString() + " / 4";
        currentCoin.text = DataManager.Instance.data.totalCoin.ToString();

        CheckCurrentSkin();
    }

    void CheckCurrentSkin()
    {
        var indexSkin = CameraManager.Instance.skinSelector.currentIndex;

        if (!SkinManager.Instance.CheckSkin(indexSkin))
        {
            for (int i = 0; i < buttonUnbox.Length; i++)
            {
                buttonUnbox[i].SetActive(i == indexSkin);
                buttonPlay[i].SetActive(false);
            }
        }

        else
        {
            for (int i = 0; i < buttonUnbox.Length; i++)
            {
                buttonPlay[i].SetActive(i == indexSkin);
            }
        }
    }

    public void SelectSkin()
    {
        var indexSkin = CameraManager.Instance.skinSelector.currentIndex;
        DataManager.Instance.data.currentSkin = indexSkin;
    }

    public void SelectRandom()
    {
        List<SkinOwned> ownedSkins = SkinManager.Instance.listSkinOwned.skins;

        int randomIndex = Random.Range(0, ownedSkins.Count);
        int selectedIndexSkin = ownedSkins[randomIndex].indexSkin;

        DataManager.Instance.data.currentSkin = selectedIndexSkin;

        CheckCurrentSkin();
    }

    public void SetSkinOwned()
    {
        var listSkin = SkinManager.Instance.listSkinOwned.skins;

        foreach (var ownedSkin in listSkin)
        {
            if (SkinManager.Instance.CheckSkin(ownedSkin.indexSkin))
            {
                skin[ownedSkin.indexSkin].SetActive(true);
            }
        }
    }

    public void DestroySkin()
    {
        foreach (var skin in skinOwned)
        {
            Destroy(skin.gameObject);
        }

        skinOwned.Clear();
    }

    public void DisableInteract()
    {
        StartCoroutine(DisableInteractCoroutine());
    }

    IEnumerator DisableInteractCoroutine()
    {
        nonInteract.SetActive(true);
        CameraSkinHandler.Instance.canMove = false;

        yield return new WaitForSeconds(1.5f);

        CameraSkinHandler.Instance.canMove = true;
        nonInteract.SetActive(false);
    }
}
