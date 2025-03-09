using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class AdjustTouchHandler : MonoBehaviour
{
    public CanvasGroup attackUI;
    public Scrollbar fadeScrollbar;
    public float fadeValue;

    public Text borderValue;

    void Start()
    {
        fadeScrollbar.onValueChanged.AddListener(UpdateFade);
    }

    private void OnEnable()
    {
        fadeScrollbar.value = DataManager.Instance.data.attackFadeValue;
        CameraManager.Instance.handler.borderValue = DataManager.Instance.data.screenBorder;

        UpdateScreenBorder();
    }

    void UpdateFade(float value)
    {
        attackUI.alpha = fadeValue;
        fadeValue = value;
    }

    public void IncreaseScreenBorder()
    {
        CameraManager.Instance.handler.borderValue++;
        ChangeScreenBorder();
    }

    public void DecreaseScreenBorder()
    {
        CameraManager.Instance.handler.borderValue--;
        ChangeScreenBorder();
    }

    void ChangeScreenBorder()
    {
        if (CameraManager.Instance.handler.borderValue > 4)
        {
            CameraManager.Instance.handler.borderValue = 0;
        }

        if (CameraManager.Instance.handler.borderValue < 0)
        {
            CameraManager.Instance.handler.borderValue = 4;
        }

        UpdateScreenBorder();
    }

    void UpdateScreenBorder()
    {
        CameraManager.Instance.handler.UpdateScreenBorder(CameraManager.Instance.handler.borderValue);
        CameraManager.Instance.handler.UpdateFO(CameraManager.Instance.handler.borderValue);

        borderValue.text = CameraManager.Instance.handler.borderValue.ToString();
    }

    public void ResetDefault()
    {
        fadeValue = 0.5f;
        attackUI.alpha = fadeValue;
        fadeScrollbar.value = fadeValue;

        CameraManager.Instance.handler.borderValue = 0;
        UpdateScreenBorder();
    }
}
