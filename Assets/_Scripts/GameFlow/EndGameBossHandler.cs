using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class EndGameBossHandler : MonoBehaviour
{
    public ScoreDisplay scorePanel;
    public TotalScoreDisplay totalScorePanel;

    public void OnEnable()
    {
        StartCoroutine(ShowEndGamePanels());
    }

    IEnumerator ShowEndGamePanels()
    {
        scorePanel.gameObject.SetActive(true);
        scorePanel.ShowScorePanel();
        yield return new WaitForSeconds(5.5f);

        totalScorePanel.gameObject.SetActive(true);
        totalScorePanel.ShowTotalScorePanel();
    }
}
