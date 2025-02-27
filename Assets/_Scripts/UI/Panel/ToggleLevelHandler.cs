using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ToggleLevelHandler : TogglePanelHandler
{

    public void UpdateData()
    {
        SelectLevelManager.Instance.ActiveCurrentLevel();
    }
}
