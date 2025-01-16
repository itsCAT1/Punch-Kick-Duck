using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HandleColider : MonoBehaviour
{
    Rigidbody rigid;
    ObjectMovement objectMovement;

    public string attackType;
    public float forcePush;
    public Vector3 offset;

    private void Start()
    {
        rigid = GetComponent<Rigidbody>();
        objectMovement = GetComponent<ObjectMovement>();
    }

    void ReflectObject()
    {
        this.transform.rotation = Quaternion.Euler(0, -this.transform.eulerAngles.y, 0);
    }

    public void IsRepelled()
    {
        Vector3 pushDirection = new Vector3(0, offset.y, offset.z).normalized;
        rigid.AddForce(pushDirection * forcePush, ForceMode.Impulse);
    }

    void OnHit()
    {
        rigid.useGravity = true;
        objectMovement.enabled = false;
        IsRepelled();
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.CompareTag(attackType))
        {
            ReflectObject();
        }
        else if (other.gameObject.CompareTag("Player"))
        {
            Player.Instance.performAttack.PerformHurt();
            OnHit();
        }
        else if (other.gameObject.CompareTag("Enemy"))
        {
            other.GetComponent<Animator>().Play("Hurt");
            //other.GetComponent<Health>().TakeDamage();
            OnHit();
        }
    }
}
