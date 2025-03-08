using DG.Tweening;
using System.Collections;
using System.Collections.Generic;
using TMPro;
using Unity.VisualScripting;
using UnityEngine;

public class ScoreDisplay : SlideHandler
{
    [Header("Score")]
    public TextMeshProUGUI newScoreValue;
    public TextMeshProUGUI newBestValue;
    public TextMeshProUGUI bestScoreValue;
    public GameObject newScorePanel;
    public GameObject newBestPanel;

    [Header("Bonus")]
    public TextMeshProUGUI heartBonusValue;

    void OnEnable()
    {
        UpdateScore();
    }

    void UpdateScore()
    {
        int score = DataInGame.Instance.score;
        int heartBonus = Player.Instance.health.currentHeart * 10;

        if (Player.Instance.health.currentHealth > 1)
        {
            heartBonus = 0;
        }

        int newScore = score + heartBonus;

        DataEndGame.Instance.UpdateData(newScore);

        UpdateUI(score, heartBonus, newScore);

    }

    void UpdateUI(int score, int heartBonus, int newScore)
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
    }

    public void ShowScorePanel()
    {
        StartCoroutine(SlideScorePanel());
    }

    IEnumerator SlideScorePanel()
    {
        RectTransform rectTransform = new RectTransform();

        Vector2 startPosition = new Vector2(0, 750);
        Vector2 endPosition = Vector2.zero;
        SlideUI(startPosition, endPosition, 0.25f);
        yield return new WaitForSeconds(5);

        startPosition = endPosition;
        endPosition = new Vector2(-1450, 0);
        SlideUI(startPosition, endPosition, 0.25f);

        yield return new WaitForSeconds(0.3f);

        this.gameObject.SetActive(false);
    }
}
