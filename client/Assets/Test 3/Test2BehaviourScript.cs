using UnityEngine;

public class Test2BehaviourScript : MonoBehaviour
{
    private readonly int aa = 0;
    [SerializeField] private int bb = 0;

    // Start is called before the first frame update
    private void Start()
    {
        Debug.LogWarning(aa);
        if (true)
            Debug.LogWarning(bb);
    }
}