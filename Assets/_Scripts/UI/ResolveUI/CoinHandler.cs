using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class CoinHandler : MonoBehaviour
{
    public TextMeshProUGUI coinUI;

    private void Start()
    {
        UpdateCoin();
    }

    public void UpdateCoin()
    {
        coinUI.text = DataManager.Instance.data.totalCoin.ToString();
    }

}
