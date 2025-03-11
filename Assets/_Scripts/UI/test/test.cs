using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.SceneManagement;

public class test : MonoBehaviour
{
    public float speed;

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
    }
}
