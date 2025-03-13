using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using UnityEngine;
using TMPro;
using UnityEngine.UI;

public class BonusPointHandler : MonoBehaviour
{
    public Image progressBar; 
    public TextMeshProUGUI beatingCounterUI; 

    public bool stayLevel;

    bool inGame => ConditionManger.Instance.currentState == GameState.InGame;

    void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<InGame>(OnInGame);
        UEventDispatcherSingleton.Instance.AddEventListener<StartGame>(OnStartGame);
    }

    void OnInGame(IUEventData uEventData)
    {
        StopAllCoroutines();

        StartCoroutine(CountdownPoint());
    }

    void OnStartGame(IUEventData uEventData)
    {
        UpdateUI();
    }

    IEnumerator CountdownPoint()
    {
        while (inGame)
        {
            UpdateUI();

            string currentState = Player.Instance.executer.GetCurrentState().Name;

            if (currentState == "Walk")
            {
                DataInGame.Instance.beatingPoint += 0.002f;
            }
            else
            {
                DataInGame.Instance.beatingPoint -= 0.002f;
            }

            CheckPoint();
            yield return new WaitForSeconds(0.001f);
        }
    }

    void UpdateUI()
    {
        progressBar.fillAmount = DataInGame.Instance.beatingPoint / 10f;
        beatingCounterUI.text = DataInGame.Instance.beatingCounter.ToString();
    }

    void CheckPoint()
    {
        if (DataInGame.Instance.beatingPoint < 0)
        {
            DataInGame.Instance.beatingPoint = 0; 

            if (!stayLevel && DataInGame.Instance.beatingCounter > 1)
            {
                DataInGame.Instance.beatingCounter--;
                DataInGame.Instance.beatingPoint = 9.9f; 
            }
        }

        if (DataInGame.Instance.beatingPoint >= 10)
        {
            DataInGame.Instance.beatingCounter++; 
            DataInGame.Instance.beatingPoint = 0;

            SetAchievement();
            AudioManager.Instance.bonusPointReached.Play();
        }
        stayLevel = true;
    }

    public void GainPoint()
    {
        DataInGame.Instance.beatingPoint++;

        CheckPoint();
    }

    public void LosePoint()
    {
        stayLevel = false;
        DataInGame.Instance.beatingPoint--;

        CheckPoint();
    }

    void SetAchievement()
    {
        if(DataInGame.Instance.beatingCounter >= 6)
        {
            AchievementManager.Instance.UnlockAchievement(5);
        }

        if (DataInGame.Instance.beatingCounter >= 9)
        {
            AchievementManager.Instance.UnlockAchievement(6);
        }
    }
}
