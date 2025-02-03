using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class InGameManager : Singleton<InGameManager>
{
    public ButtonHandler button;
    public LivesHandler lives;
    public BonusPointHandler bonusPoint;
}
