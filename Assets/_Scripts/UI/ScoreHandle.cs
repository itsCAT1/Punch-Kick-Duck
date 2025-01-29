using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ScoreHandle : MonoBehaviour
{
    public Text levelUI;
    public Text scoreUI;


    void Update()
    {
        UpdateScore();
    }

    void UpdateScore()
    {
        levelUI.text = "LEVEL " + DataBase.Instance.currentMap.ToString();
        scoreUI.text = DataInGame.Instance.score.ToString();
    }
}
