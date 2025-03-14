using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ToggleGooglePlay : MonoBehaviour
{
    Animator animator;
    bool isExpanded = false;
    bool isAnimating = false;

    public float duration;
    public GameObject panelExpand;
    public AudioSource soundExpand, soundCollapse;
    void Start()
    {
        UpdatePanelState();

        animator = GetComponent<Animator>();
    }

    void UpdatePanelState()
    {
        if (isExpanded)
        {
            panelExpand.SetActive(true);
        }
        else
        {
            panelExpand.SetActive(false);
        }
    }

    public void OnClick()
    {
        if (!isAnimating)
        {
            isExpanded = !isExpanded;

            if (isExpanded)
            {
                UpdatePanelState();
                soundExpand.Play();
                animator.Play("Expand");
            }
            else
            {
                animator.Play("Collapse");
                soundCollapse.Play();
                Invoke(nameof(UpdateAfterAnimation), duration);
            }
            isAnimating = true;


            Invoke(nameof(ResetAnimation), duration);
        }
    }

    private void ResetAnimation()
    {
        isAnimating = false;
    }

    private void UpdateAfterAnimation()
    {
        UpdatePanelState();
    }

    public void ResetState()
    {
        isExpanded = false;
        animator.Play("Collapse");
        Invoke(nameof(UpdateAfterAnimation), duration);
    }
}
