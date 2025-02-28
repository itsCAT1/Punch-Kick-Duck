using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class TotalScoreDisplay : SlideHandler
{
    public TextMeshProUGUI totalScoreUI;
    public TextMeshProUGUI[] scoreUI;
    public Image[] starUI;

    int totalScore;

    void OnEnable()
    {
        UpdateTotalScore();
    }

    public void UpdateTotalScore()
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

    public void ShowTotalScorePanel()
    {
        StartCoroutine(SlideTotalScorePanel());
    }

    IEnumerator SlideTotalScorePanel()
    {
        RectTransform rectTransform = new RectTransform();

        Vector2 startPosition = new Vector2(0, -1050);
        Vector2 endPosition = new Vector2(0, 18);
        SlideUI(startPosition, endPosition, 0.25f);
        yield return new WaitForSeconds(8);

        this.gameObject.SetActive(false);
    }
}
