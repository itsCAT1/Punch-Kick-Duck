using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyTakedowned : MonoBehaviour
{
    public float forcePush = 2;
    Rigidbody rb;

    private void Start()
    {
        rb = GetComponent<Rigidbody>();
    }

    public void IsRepelledEnemy()
    {
        Vector3 startPos = this.transform.position;
        Vector3 endPos = startPos - new Vector3(2 * this.transform.forward.x, -1f, 1);

        StartCoroutine(AddForceCoroutineEnemy(startPos, endPos));
    }


    IEnumerator AddForceCoroutineEnemy(Vector3 startPos, Vector3 endPos)
    {
        float count = 0;
        float duration = 1;

        while (count < duration)
        {
            this.transform.position = Vector3.Slerp(startPos, endPos, count * 2 / duration);

            count += Time.deltaTime;
            yield return null;
        }
    }

    private void Update()
    {
        if(Input.GetKeyDown(KeyCode.Space))
        {
            Vector3 startPos = this.transform.position;
            Vector3 endPos = startPos - new Vector3(2 * this.transform.forward.x, -1f, 1);
            rb.AddForceAtPosition(this.transform.position, endPos, ForceMode.Impulse);
        }
    }
}
