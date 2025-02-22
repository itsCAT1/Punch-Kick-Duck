using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[Serializable]
public class SkinOwned
{
    public int id;
    public bool haveSkin;
}

public class SelectCharactorManager : MonoBehaviour
{
    public List<SkinOwned> skins;

}
