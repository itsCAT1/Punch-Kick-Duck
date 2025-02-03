using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ScoreHandler : MonoBehaviour
{
    public Text levelUI;
    public Text scoreUI;


    void Update()
    {
        UpdateScore();
    }

    void UpdateScore()
    {
        levelUI.text = "LEVEL " + DataManager.Instance.data.currentMap.ToString();
        scoreUI.text = DataInGame.Instance.score.ToString();
    }
}
