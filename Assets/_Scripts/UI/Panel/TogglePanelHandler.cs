using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TogglePanelHandler : MonoBehaviour
{
    Animator animator;
    bool isExpanded = false;
    bool isAnimating = false;

    public float duration;
    public GameObject panelExpand, panelCollapse;
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
            panelCollapse.SetActive(false);
            panelExpand.SetActive(true);
        }
        else
        {
            panelCollapse.SetActive(true);
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
