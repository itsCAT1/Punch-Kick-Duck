using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.SceneManagement;

public class test : MonoBehaviour
{
    public float speed;

    private void Update()
    {
        speed = Time.timeScale;
    }
}
