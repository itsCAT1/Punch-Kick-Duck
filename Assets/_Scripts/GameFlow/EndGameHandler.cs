using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class EndGameHandler : MonoBehaviour
{
    [Header("Score")]
    public Text newScoreUI;
    public Text newBestUI;
    public Text bestScoreUI;
    public GameObject newScorePanel;
    public GameObject newBestPanel;

    [Header("Bonus")]
    public Text outrunBonusUI;
    public Text heartBonusUI;

    [Header("Total")]
    public Text totalScoreUI;

    void Start()
    {
        UpdateResult();
    }

    void UpdateResult()
    {
        int score = DataInGame.Instance.score;
        int outrunScore = DataEndGame.Instance.bestStreak * DataEndGame.Instance.bestBeatingCounter;

        int heartBonus = Player.Instance.health.currentHeart * 10;

        if (Player.Instance.health.currentHealth == 2)
        {
            heartBonus = 0;
        }
        
        int newScore = score + outrunScore + heartBonus;
        int totalScore = newScore + DataManager.Instance.data.totalScore;
        
        ShowResult(score, outrunScore, heartBonus, newScore, totalScore);
        UpdateData(newScore, totalScore);
    }

    void ShowResult(int score, int outrunScore, int heartBonus, int newScore, int totalScore)
    {
        if (newScore > DataManager.Instance.currentBestScore)
        {
            newBestPanel.SetActive(true);
            newScorePanel.SetActive(false);
            newBestUI.text = newScore.ToString();
        }
        else
        {
            newBestPanel.SetActive(false);
            newScorePanel.SetActive(true);
            newScoreUI.text = newScore.ToString();
        }

        bestScoreUI.text = DataManager.Instance.listLevel.data[DataManager.Instance.data.currentMap - 1].bestScore.ToString();

        outrunBonusUI.text = DataEndGame.Instance.bestStreak.ToString() + " x " + DataEndGame.Instance.bestBeatingCounter + " = " + outrunScore.ToString();
        heartBonusUI.text = heartBonus.ToString();
        totalScoreUI.text = totalScore.ToString();
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
