using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[Serializable]
public class DataLevel
{
    public int bestScore;
    public bool isCompleted;
}

[Serializable]
public class ListDataLevel
{
    public List<DataLevel> data;
}
