using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class BossHandler : MonoBehaviour
{
    public Image progressHeathUI;


    private void Update()
    {
        UpdateLives();
    }

    public void UpdateLives()
    {
        if(Boss.Instance != null) 
            progressHeathUI.fillAmount = Boss.Instance.health.currentHealth / 30f;
    }
}
