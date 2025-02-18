using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class EndGameBossHandler : MonoBehaviour
{
    [Header("Score")]
    public Text newScoreValue;
    public Text newBestValue;
    public Text bestScoreValue;
    public GameObject newScorePanel;
    public GameObject newBestPanel;

    [Header("Bonus")]
    public Text heartBonusValue;

    [Header("Total")]
    public Text totalScoreValue;


    void Start()
    {
        UpdateResult();
    }

    void UpdateResult()
    {
        int score = DataInGame.Instance.score;

        int heartBonus = Player.Instance.health.currentHeart * 10;

        if (Player.Instance.health.currentHealth == 2)
        {
            heartBonus = 0;
        }

        int newScore = score + heartBonus;
        int totalScore = newScore + DataManager.Instance.data.totalScore;

        ShowResult(score, heartBonus, newScore, totalScore);
        UpdateData(newScore, totalScore);
    }

    void ShowResult(int score, int heartBonus, int newScore, int totalScore)
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

        bestScoreValue.text = DataManager.Instance.listLevel.data[DataManager.Instance.data.currentMap - 1].bestScore.ToString();
        heartBonusValue.text = heartBonus.ToString();
        totalScoreValue.text = totalScore.ToString();
    }

    void UpdateData(int newScore, int totalScore)
    {
        if (newScore > DataManager.Instance.currentBestScore)
        {
            DataManager.Instance.listLevel.data[DataManager.Instance.data.currentMap - 1].bestScore = newScore;
        }

        DataManager.Instance.data.totalScore = totalScore;
    }
}
