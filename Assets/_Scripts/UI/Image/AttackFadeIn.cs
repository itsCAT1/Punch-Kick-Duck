using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AttackFadeIn : UIFadeIn
{

    private void OnEnable()
    {
        SetFadeValue();
    }

    public void SetFadeValue()
    {
        fadeValue = DataManager.Instance.data.attackFadeValue;
    }
}
