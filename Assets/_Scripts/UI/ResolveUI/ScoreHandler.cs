using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class ScoreHandler : MonoBehaviour
{
    public TextMeshProUGUI levelUI;
    public TextMeshProUGUI scoreUI;

    private void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<InGame>(UpdateOnStart);
    }

    public void UpdateOnStart(IUEventData uEventData)
    {
        levelUI.text = "LEVEL " + DataManager.Instance.data.currentMap.ToString();
        scoreUI.text = DataInGame.Instance.score.ToString();
    }

    public void UpdateScore()
    {
        levelUI.text = "LEVEL " + DataManager.Instance.data.currentMap.ToString();
        scoreUI.text = DataInGame.Instance.score.ToString();
    }
}
