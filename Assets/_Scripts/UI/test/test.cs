using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.SceneManagement;

public class test : MonoBehaviour
{
    public float speed;

    Rigidbody Rigidbod;

    private void Start()
    {
        Rigidbod = GetComponent<Rigidbody>();
    }
    private void Update()
    {
        this.transform.position += new Vector3(Input.GetAxisRaw("Horizontal") * speed * Time.deltaTime,
            Input.GetAxisRaw("Vertical") * speed * Time.deltaTime, 0); 
    }
}
