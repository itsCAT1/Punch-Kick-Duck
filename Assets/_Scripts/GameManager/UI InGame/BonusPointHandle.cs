using System.Collections;
using UnityEngine;
using UnityEngine.UI;

public class BonusPointHandle : MonoBehaviour
{
    public Image progressBar; 
    public Text beatingCounterUI; 

    public bool stayLevel; 

    void Start()
    {
        StartGame();
    }

    private void Update()
    {
        if (Input.GetKeyDown(KeyCode.T))
        {
            GainPoint();
        }

        if (Input.GetKeyDown(KeyCode.G))
        {
            LosePoint(); 
        }
    }

    void StartGame()
    {
        StartCoroutine(CountdownPoint());
    }

    IEnumerator CountdownPoint()
    {
        while (DataInGame.Instance.isStart)
        {
            progressBar.fillAmount = DataInGame.Instance.beatingPoint / 10f;
            beatingCounterUI.text = DataInGame.Instance.beatingCounter.ToString();

            DataInGame.Instance.beatingPoint -= 0.001f;

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
