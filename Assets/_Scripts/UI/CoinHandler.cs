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
        UpdateScore();
    }

    public void UpdateScore()
    {
        coinUI.text = DataManager.Instance.data.totalCoin.ToString();
    }

}
