using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[Serializable]
public class DailyQuestData
{
    public int id;
    public string title;
    public string description;
    public int targetValue;
}

[CreateAssetMenu(fileName = "ListDataQuest", menuName = "ScriptableObject/Quests", order = 1)]
public class ListDataQuest : ScriptableObject
{
    public List<DailyQuestData> questData;
}