using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BossThrowing : MonoBehaviour
{
    public GameObject[] fruitAvatar;
    public Transform[] fruitPosition;
    public GameObject[] fruitPrefab;

    public int fruitType;

    private void Update()
    {
        if (Input.GetKeyDown(KeyCode.Space))
        {
            Boss.Instance.executer.SetCurrentState("Throw");
        }
    }


    public void SetFruit()
    {
        fruitType = Random.Range(0, 3);
        fruitAvatar[fruitType].SetActive(true);
    }

    void CreateFruit()
    {
        fruitAvatar[fruitType].SetActive(false);
        Instantiate(fruitPrefab[fruitType], fruitPosition[fruitType].position, this.transform.rotation);
    }
}
