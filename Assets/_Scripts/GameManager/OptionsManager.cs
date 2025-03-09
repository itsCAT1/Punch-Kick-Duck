using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class OptionsManager : Singleton<OptionsManager>
{
    public GameObject panelOptions, panelAdjustTouch, panelAttack, panelPause;

    public AdjustTouchHandler adjustTouch;
    public AttackFadeIn attackFadeIn;

    public void SelectAdjustTouch()
    {
        panelAdjustTouch.SetActive(true);
        panelAttack.SetActive(true);
        panelOptions.SetActive(false);

        CameraManager.Instance.OnAdjustTouch();
    }

    public void BackToOptions()
    {
        panelAdjustTouch.SetActive(false);
        panelAttack.SetActive(false);
        panelOptions.SetActive(true);
        CameraManager.Instance.OutAdjustTouch();

        SetData();
    }

    public void SetData()
    {
        DataManager.Instance.data.attackFadeValue = adjustTouch.fadeValue;
        DataManager.Instance.data.screenBorder = CameraManager.Instance.handler.borderValue;
        attackFadeIn.SetFadeValue();
    }

    public void BackToGame()
    {
        panelPause.SetActive(true);

        if (!DataManager.Instance.data.showTutorial) ConditionManger.Instance.SetState(GameState.InGame);
        else ConditionManger.Instance.SetState(GameState.Tutorial);
    }

    public void BackToMenu()
    {
        UEventData uEventData = new UEventData();
        UEventDispatcherSingleton.Instance.Invoke<MenuGame>(uEventData);
    }
}
