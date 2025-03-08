using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class OptionsManager : Singleton<OptionsManager>
{
    public GameObject panelOptions, panelAdjustTouch, panelAttack;

    public ControlVisibilityHandler controlVisibility;
    public AttackFadeIn attackFadeIn;

    public void SelectAdjustTouch()
    {
        panelAdjustTouch.SetActive(true);
        panelAttack.SetActive(true);
        panelOptions.SetActive(false);
    }

    public void BackToOptions()
    {
        panelAdjustTouch.SetActive(false);
        panelAttack.SetActive(false);
        panelOptions.SetActive(true);

        SetData();
    }

    public void SetData()
    {
        DataManager.Instance.data.attackFadeValue = controlVisibility.fadeValue;
        attackFadeIn.SetFadeValue();
    }
}
