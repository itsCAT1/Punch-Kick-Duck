using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class EndGameHandler : MonoBehaviour
{
    [Header("Score")]
    public TextMeshProUGUI resultUI;
    public TextMeshProUGUI newScoreValue;
    public TextMeshProUGUI newBestValue;
    public TextMeshProUGUI bestScoreValue;
    public GameObject newScorePanel;
    public GameObject newBestPanel;

    [Header("Bonus")]
    public TextMeshProUGUI outrunBonusValue;
    public TextMeshProUGUI heartBonusValue;

    [Header("Total")]
    public TextMeshProUGUI totalScoreValue;

    void Start()
    {
        UpdateResult();
    }

    void UpdateResult() 
    {
        int score = DataInGame.Instance.score;
        int outrunScore = DataInGame.Instance.bestStreak * DataInGame.Instance.beatingCounter;

        int heartBonus = Player.Instance.health.currentHeart * 10;

        if (Player.Instance.health.currentHealth > 1)
        {
            heartBonus = 0;
        }
        
        int newScore = score + outrunScore + heartBonus;

        DataEndGame.Instance.UpdateData(newScore);

        UpdateUI(score, outrunScore, heartBonus, newScore);

    }

    void UpdateUI(int score, int outrunScore, int heartBonus, int newScore)
    {
        if (newScore > DataManager.Instance.currentBestScore)
        {
            newBestPanel.SetActive(true);
            newScorePanel.SetActive(false);
            newBestValue.text = newScore.ToString();
        }
        else
        {
            newBestPanel.SetActive(false);
            newScorePanel.SetActive(true);
            newScoreValue.text = newScore.ToString();
        }

        resultUI.text = "LEVEL  <size=110>" + DataManager.Instance.data.currentMap + "</size>  RESULT";

        bestScoreValue.text = DataManager.Instance.listLevel.data[DataManager.Instance.data.currentMap - 1].bestScore.ToString();
        outrunBonusValue.text = DataInGame.Instance.bestStreak.ToString() + " x " + DataInGame.Instance.beatingCounter + " = " + outrunScore.ToString();
        heartBonusValue.text = heartBonus.ToString();
        totalScoreValue.text = DataManager.Instance.data.totalScore.ToString();
    }
}
