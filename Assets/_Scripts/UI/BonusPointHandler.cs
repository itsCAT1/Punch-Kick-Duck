using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using UnityEngine;
using UnityEngine.UI;

public class BonusPointHandler : MonoBehaviour
{
    public Image progressBar; 
    public Text beatingCounterUI; 

    public bool stayLevel; 

    void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<StartGame>(StartGame);
    }

    private void Update()
    {
        progressBar.fillAmount = DataInGame.Instance.beatingPoint / 10f;
        beatingCounterUI.text = DataInGame.Instance.beatingCounter.ToString();
    }

    void StartGame(IUEventData uEventData)
    {
        StartCoroutine(CountdownPoint());
    }

    IEnumerator CountdownPoint()
    {
        ConditionManger.Instance.startGame = true;
        while (ConditionManger.Instance.startGame)
        {
            

            string currentState = Player.Instance.executer.GetCurrentState().Name;

            if (currentState == "Walk")
            {
                DataInGame.Instance.beatingPoint += 0.003f;
            }
            else
            {
                DataInGame.Instance.beatingPoint -= 0.003f;
            }

            CheckPoint();
            yield return null;
        }
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
}
