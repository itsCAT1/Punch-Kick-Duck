using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class PlayerLivesUI : MonoBehaviour
{
    Text livesUI;

    void Start()
    {
        livesUI = GetComponent<Text>();
    }

    void Update()
    {
        livesUI.text = Player.Instance.health.currentHealth.ToString();
    }
}
