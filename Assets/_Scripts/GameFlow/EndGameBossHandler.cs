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
    public AudioSource soundEndGame;
    public AudioSource soundTotalScore;

    public void OnEnable()
    {
        StartCoroutine(ShowEndGamePanels());
    }

    IEnumerator ShowEndGamePanels()
    {
        scorePanel.gameObject.SetActive(true);
        scorePanel.ShowScorePanel();
        soundEndGame.PlayDelayed(0.5f);

        yield return new WaitForSeconds(5.5f);

        soundTotalScore.PlayDelayed(0.25f);
        totalScorePanel.gameObject.SetActive(true);
        totalScorePanel.ShowTotalScorePanel();
    }
}
