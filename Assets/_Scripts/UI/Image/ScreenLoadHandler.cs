using DG.Tweening;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ScreenLoadHandler : MonoBehaviour
{
    public CanvasGroup canvasGroup;
    public float fadeValue;
    public float fadeDuration;

    private void Awake()
    {
        canvasGroup = GetComponent<CanvasGroup>();
    }

    private void Start()
    {
        Flash();
    }

    [ContextMenu("fade")]
    public void Flash()
    {
        StartCoroutine(StartF());
    }

    IEnumerator StartF()
    {
        yield return new WaitForSeconds(fadeDuration);

        Debug.Log("fade");
        canvasGroup.DOFade(0, fadeDuration);
        this.gameObject.SetActive(false);
    }
}
