using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TutorialHandler : MonoBehaviour
{
    public GameObject tickUI;

    void OnEnable()
    {
        CheckState();
    }


    public void ToggleButton()
    {
        DataManager.Instance.data.showTutorial = !DataManager.Instance.data.showTutorial;

        CheckState();
    }

    void CheckState()
    {
        if (DataManager.Instance.data.showTutorial)
        {
            tickUI.SetActive(true);
        }
        else tickUI.SetActive(false);
    }
}
