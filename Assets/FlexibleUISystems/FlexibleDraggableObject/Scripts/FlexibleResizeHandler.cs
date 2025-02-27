using UnityEngine;
using UnityEngine.EventSystems;

public enum HandlerType { TopRight, Right, BottomRight, Bottom, BottomLeft, Left, TopLeft, Top }

[RequireComponent(typeof(EventTrigger))]
public class FlexibleResizeHandler : MonoBehaviour
{
    public HandlerType Type;
    public RectTransform Target;
    public Vector2 MinSize = new Vector2(50, 50);
    public Vector2 MaxSize = new Vector2(800, 800);

    void Start()
    {
        GetComponent<EventTrigger>().AddEventTrigger(OnDrag, EventTriggerType.Drag);
    }

    void OnDrag(BaseEventData data)
    {
        var ped = (PointerEventData)data;
        var (hEdge, vEdge) = GetEdges();

        if (hEdge.HasValue) ResizeEdge(hEdge.Value, ped.delta.x, true);
        if (vEdge.HasValue) ResizeEdge(vEdge.Value, ped.delta.y, false);
    }

    (RectTransform.Edge? h, RectTransform.Edge? v) GetEdges() => Type switch
    {
        HandlerType.TopRight => (RectTransform.Edge.Left, RectTransform.Edge.Bottom),
        HandlerType.Right => (RectTransform.Edge.Left, null),
        HandlerType.BottomRight => (RectTransform.Edge.Left, RectTransform.Edge.Top),
        HandlerType.Bottom => (null, RectTransform.Edge.Top),
        HandlerType.BottomLeft => (RectTransform.Edge.Right, RectTransform.Edge.Top),
        HandlerType.Left => (RectTransform.Edge.Right, null),
        HandlerType.TopLeft => (RectTransform.Edge.Right, RectTransform.Edge.Bottom),
        HandlerType.Top => (null, RectTransform.Edge.Bottom),
        _ => throw new System.ArgumentOutOfRangeException()
    };

    void ResizeEdge(RectTransform.Edge edge, float delta, bool isHorizontal)
    {
        float pivot = isHorizontal ? Target.pivot.x : Target.pivot.y;
        float size = isHorizontal ? Target.rect.width : Target.rect.height;
        float min = isHorizontal ? MinSize.x : MinSize.y;
        float max = isHorizontal ? MaxSize.x : MaxSize.y;

        if (edge == RectTransform.Edge.Right || edge == RectTransform.Edge.Top)
            Target.SetInsetAndSizeFromParentEdge(edge, 
                (isHorizontal ? Screen.width - Target.position.x : Screen.height - Target.position.y) - pivot * size,
                Mathf.Clamp(size - delta, min, max));
        else
            Target.SetInsetAndSizeFromParentEdge(edge, 
                (isHorizontal ? Target.position.x : Target.position.y) - pivot * size,
                Mathf.Clamp(size + delta, min, max));
    }
}