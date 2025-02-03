using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class CoinHandler : MonoBehaviour
{
    public Text coinUI;


    void Update()
    {
        UpdateScore();
    }

    void UpdateScore()
    {
        coinUI.text = DataManager.Instance.data.totalCoin.ToString();
    }

}
