using UnityEngine;
using UnityEngine.UI;

public class ImageTextureScroller : MonoBehaviour
{
    public Image img;
    public float speedX, speedY;

    private Material material;

    void Start()
    {
        material = img.material; 
    }

    void Update()
    {
        Vector2 offset = material.mainTextureOffset + new Vector2(speedX, speedY) * Time.deltaTime;

        offset.x = offset.x % 1f;
        offset.y = offset.y % 1f;

        material.mainTextureOffset = offset;
    }
}