using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class SelectLevelHandler : MonoBehaviour
{
    public Animator animator;

    public GameObject conformLevel;
    public GameObject selectLevel;

    public Button buttonSelect;
    public Button buttonConform;



    public void OpenPanel()
    {
        selectLevel.SetActive(false);
        conformLevel.SetActive(true);

        Debug.LogWarning("a");
        animator.Play("Open");
        //StartCoroutine(StartSelect());
    }

    IEnumerator StartSelect()
    {
        
        

        buttonConform.interactable = false;

        yield return new WaitForSeconds(0.3f);
        
        buttonConform.interactable = true;
    }

    public void ClosePanel()
    {
        StartCoroutine(StartConform());
    }

    IEnumerator StartConform()
    {
        animator.Play("Close");
        buttonConform.interactable = false;

        yield return new WaitForSeconds(0.3f);

        conformLevel.SetActive(false);
        selectLevel.SetActive(true);
        buttonSelect.interactable = true;
    }
}
