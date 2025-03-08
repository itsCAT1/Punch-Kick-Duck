using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ControlVisibilityHandler : MonoBehaviour
{
    public CanvasGroup attackUI;
    public Scrollbar fadeScrollbar;
    public float fadeValue;

    void Start()
    {
        fadeScrollbar.onValueChanged.AddListener(UpdateFade);
    }

    private void OnEnable()
    {
        fadeScrollbar.value = DataManager.Instance.data.attackFadeValue;
    }

    void UpdateFade(float value)
    {
        attackUI.alpha = fadeValue;
        fadeValue = value;
    }
}
