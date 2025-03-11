using DG.Tweening;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class UIFadeIn : MonoBehaviour
{
    public CanvasGroup canvasGroup;
    public float fadeValue;

    private void Awake()
    {
        canvasGroup = GetComponent<CanvasGroup>();
    }

    private void OnEnable()
    {
        FadeIn();
    }

    public void FadeIn()
    {
        canvasGroup.alpha = 0;
        canvasGroup.DOFade(fadeValue, 1);
    }

    public void FlashFade()
    {
        StartCoroutine(StartFade());
    }

    IEnumerator StartFade()
    {
        canvasGroup.alpha = 0;
        canvasGroup.DOFade(fadeValue, 1);

        yield return new WaitForSeconds(1);

        canvasGroup.DOFade(0, 1);
        this.gameObject.SetActive(false);
    }
}
