using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class TotalScoreHandler : MonoBehaviour
{
    public TextMeshProUGUI totalScoreUI;
    public TextMeshProUGUI[] scoreUI;
    public Image[] starUI;

    int totalScore;

    public void UpdateScore()
    {
        totalScore = 0;
        var data = DataManager.Instance.listLevel.data;

        for (int i = 0; i < data.Count; i++)
        {
            scoreUI[i].text = data[i].bestScore.ToString();

            if (data[i].isCompleted)
            {
                starUI[i].color = new Color32(245, 164, 60, 255);
            }
            else
            {
                starUI[i].color = Color.white;
            }

            totalScore += data[i].bestScore;
        }

        totalScoreUI.text = "TOTAL SCORE  <size=79>" + totalScore + "</size>";
    }
}
