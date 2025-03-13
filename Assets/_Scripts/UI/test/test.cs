using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.SceneManagement;

public class test : MonoBehaviour
{
    private void Update()
    {
        if (Input.GetKeyDown(KeyCode.B))
        {
            Player.Instance.health.TakeDamage();
        }

        if (Input.GetKeyDown(KeyCode.N))
        {
            DataPointManager.Instance.GainPoint();
        }


        if (Input.GetKeyDown(KeyCode.G))
        {
            Boss.Instance.health.TakeDamage();
            DataPointManager.Instance.GainPoint();
        }
    }
}
