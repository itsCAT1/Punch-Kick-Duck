using UnityEditor;
using UnityEngine;

public class RemoveMissingScripts : MonoBehaviour
{
    /*[MenuItem("Tools/Clean Up Missing Scripts")]
    private static void CleanMissingScripts()
    {
        int totalRemoved = 0;

        GameObject[] allGameObjects = Resources.FindObjectsOfTypeAll<GameObject>();

        foreach (GameObject obj in allGameObjects)
        {
            int removed = GameObjectUtility.RemoveMonoBehavioursWithMissingScript(obj);
            totalRemoved += removed;
        }

        Debug.Log($"Removed {totalRemoved} Missing Scripts.");
    }*/
}
