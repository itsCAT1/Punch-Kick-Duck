using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.SceneManagement;

public class test : MonoBehaviour, IPointerDownHandler, IDragHandler
{
    public RectTransform rectTransform;
    public Canvas canvas;
    private Vector2 startMousePos;
    private Vector2 startSize;

    public void OnPointerDown(PointerEventData eventData)
    {
        startMousePos = eventData.position;
    }

    public void OnDrag(PointerEventData eventData)
    {
        rectTransform.anchoredPosition += new Vector2(0, eventData.delta.y / canvas.scaleFactor);
    }

    [ContextMenu ("load")]
    public void Load()
    {
        SceneManager.LoadScene(0);
    }

    [ContextMenu("loadsk")]
    public void Loadsk()
    {
        SceneManager.LoadScene(1);
    }
}
