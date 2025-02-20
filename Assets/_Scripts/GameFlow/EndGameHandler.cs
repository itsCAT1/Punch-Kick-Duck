using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class EndGameHandler : MonoBehaviour
{
    [Header("Score")]
    public Text resultUI;
    public Text newScoreValue;
    public Text newBestValue;
    public Text bestScoreValue;
    public GameObject newScorePanel;
    public GameObject newBestPanel;

    [Header("Bonus")]
    public Text outrunBonusValue;
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
        int outrunScore = DataInGame.Instance.bestStreak * DataInGame.Instance.beatingCounter;

        int heartBonus = Player.Instance.health.currentHeart * 10;

        if (Player.Instance.health.currentHealth == 2)
        {
            heartBonus = 0;
        }
        
        int newScore = score + outrunScore + heartBonus;
        
        int totalScore = newScore;

        foreach (var scoreEachLevel in DataManager.Instance.listLevel.data)
        {
            
        }

        DataEndGame.Instance.UpdateData(newScore, totalScore);

        ShowResult(score, outrunScore, heartBonus, newScore, totalScore);

    }

    void ShowResult(int score, int outrunScore, int heartBonus, int newScore, int totalScore)
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
        totalScoreValue.text = totalScore.ToString();
    }
}
