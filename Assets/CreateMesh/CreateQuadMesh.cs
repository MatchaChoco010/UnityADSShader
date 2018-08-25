using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CreateQuadMesh : MonoBehaviour {

	void Start () {
		var mesh = new Mesh ();

		var vertices = new List<Vector3> {
			new Vector3 (-1, -1, 0),
			new Vector3 (-1, 1, 0),
			new Vector3 (1, 1, 0),
			new Vector3 (1, -1, 0),
		};
		mesh.SetVertices (vertices);

		var triangles = new List<int> { 0, 1, 2, 2, 3, 0 };
		mesh.SetTriangles (triangles, 0);

		var colors = new List<Color> {
			Color.blue,
			Color.red,
			Color.green,
			Color.magenta
		};
		mesh.SetColors (colors);

		var uvs = new List<Vector2> {
			new Vector2 (0, 0),
			new Vector2 (0, 1),
			new Vector2 (1, 1),
			new Vector2 (1, 0),
		};
		mesh.SetUVs (0, uvs);

		var meshFilter = GetComponent<MeshFilter> ();
		meshFilter.mesh = mesh;
	}

}
