using UnityEngine;
using UnityEngine.EventSystems;

public class drag : MonoBehaviour, IDragHandler, IBeginDragHandler
{
    public RectTransform rectTransform;
    public Canvas canvas;

    public CanvasGroup canvasGroup;

    public void OnBeginDrag(PointerEventData eventData)
    {
        canvasGroup.alpha = 0.6f;
        canvasGroup.blocksRaycasts = false;
    }

    public void OnDrag(PointerEventData eventData)
    {
        
    }

}
