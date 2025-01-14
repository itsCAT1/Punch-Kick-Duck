using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyTakedowned : MonoBehaviour
{
    Rigidbody rb;

    private void Start()
    {
        rb = GetComponent<Rigidbody>();
    }

    public void Die()
    {
        rb.AddForce(this.transform.position * 3, ForceMode.Impulse);

        rb.AddTorque(new Vector3(Random.Range(0, 90), 0, 0));

        GetComponent<Collider>().enabled = false;

        Destroy(gameObject, 2f);
    }

    private void Update()
    {
        if(Input.GetKeyDown(KeyCode.Space))
        {
            Debug.Log("die");
            rb.AddForce(this.transform.position * 300, ForceMode.Impulse);

            rb.AddTorque(new Vector3(Random.Range(0, 90), 0, 0));
        }
    }
}
