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

        DataEndGame.Instance.UpdateData(newScore);

        ShowResult(score, heartBonus, newScore);

    }

    void ShowResult(int score, int heartBonus, int newScore)
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
        totalScoreValue.text = totalScoreValue.ToString();
    }
}
