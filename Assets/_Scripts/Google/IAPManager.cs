using UnityEngine;
using UnityEngine.Purchasing;

public class IAPManager : MonoBehaviour
{
    private string removeADS = "com.game3d.punchkickduck.removeads";
    private string skinRedFox = "com.game3d.punchkickduck.skinredfox";

    public void OnPurchaseCompleted(Product product)
    {
        if (product.definition.id == removeADS)
        {
            Debug.Log("Remove ADS");
        }

        else if (product.definition.id == skinRedFox)
        {
            Debug.Log("Bought skin Red Fox");
        }
    }

    public void OnPurchaseFailure(Product product, PurchaseFailureReason reason)
    {
        Debug.Log("Your purchase failed because: " + reason);
    }
}