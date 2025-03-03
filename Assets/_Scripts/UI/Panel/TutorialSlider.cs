using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TutorialSlider : SlideHandler
{
    public GameObject noteScore, noteBonusPoint, noteHeart;
    public HintSlider hintSlider;

    private void Update()
    {
        if(Input.GetKeyDown(KeyCode.W))
        {
            SlideNoteScore();
        }

        if (Input.GetKeyDown(KeyCode.E))
        {
            noteScore.GetComponent<UIFadeIn>().FadeIn();
        }
    }

    public void SlideNoteScore()
    {
        StartCoroutine(StartSlideScore());
    }

    IEnumerator StartSlideScore()
    {
        Vector2 startPos = Vector2.zero;
        Vector2 endPos = new Vector2(0, 1080);
        SlideUI(startPos, endPos, 0.5f);

        yield return new WaitForSecondsRealtime(0.5f);

        noteScore.SetActive(true);
        noteScore.GetComponent<UIFadeIn>().FadeIn();
    }

    public void SlideNoteBonusPoint()
    {
        StartCoroutine(StartSlideBonusPoint());
    }

    IEnumerator StartSlideBonusPoint()
    {
        Vector2 startPos = new Vector2(0, 1080);
        Vector2 endPos = new Vector2(633, 1118);
        SlideUI(startPos, endPos, 0.4f);

        yield return new WaitForSecondsRealtime(0.4f);

        noteScore.SetActive(false);
        noteBonusPoint.SetActive(true);
        noteBonusPoint.GetComponent<UIFadeIn>().FadeIn();
    }

    public void SlideNoteHeart()
    {
        StartCoroutine(StartSlideNoteHeart());
    }

    IEnumerator StartSlideNoteHeart()
    {
        Vector2 startPos = new Vector2(633, 1118);
        Vector2 endPos = new Vector2(773, 1118);
        SlideUI(startPos, endPos, 0.3f);

        yield return new WaitForSecondsRealtime(0.3f);

        noteBonusPoint.SetActive(false);
        noteHeart.SetActive(true);
        noteHeart.GetComponent<UIFadeIn>().FadeIn();
    }

    public void SlideEndTutorial()
    {
        StartCoroutine(StartSlideEnd());
    }

    IEnumerator StartSlideEnd()
    {
        noteHeart.SetActive(false);

        Vector2 startPos = new Vector2(773, 1118);
        Vector2 endPos = new Vector2(773, 0);
        SlideUI(startPos, endPos, 0.5f);
        hintSlider.CloseHint();

        yield return new WaitForSecondsRealtime(0.5f);

        UEventData uEventData = new UEventData();
        UEventDispatcherSingleton.Instance.Invoke<RestartGame>(uEventData);
        UEventDispatcherSingleton.Instance.Invoke<InGame>(uEventData);
    }
}
