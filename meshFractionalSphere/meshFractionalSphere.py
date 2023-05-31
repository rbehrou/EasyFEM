import numpy as np
from scipy.spatial import Delaunay
import meshio

class MeshFractionalSphere:
    """
    The mesh class
    """
    def __init__(self, Radius, NumRadial, NumTheta, NumPhi, ThetaFraction, PhiFraction):
        """
        Constructor
        """
        self.Radius        = Radius
        self.NumRadial     = NumRadial
        self.NumTheta      = NumTheta
        self.NumPhi        = NumPhi
        self.ThetaFraction = ThetaFraction
        self.PhiFraction   = PhiFraction
        
        # Generate mesh
        self.FeCoord, self.FeTopo = self.generate_mesh()

    def generate_mesh(self):
        """
        Mesh sphere
        """
        # Create the mesh grid (0 <= theta <= pi, 0 <= phi <= 2*pi)
        radial = np.linspace(0.0, self.Radius, self.NumRadial)
        theta  = np.linspace(0.0, 1.0 * np.pi * self.ThetaFraction, self.NumTheta)
        phi    = np.linspace(0.0, 2.0 * np.pi * self.PhiFraction, self.NumPhi)

        # Generate the nodal coordinates
        r, th, ph = np.meshgrid(radial, theta, phi, indexing='ij')
        x = r * np.sin(th) * np.cos(ph)
        y = r * np.sin(th) * np.sin(ph)
        z = r * np.cos(th)

        # Reshape the arrays
        FeCoord = np.vstack([x.ravel(), y.ravel(), z.ravel()]).T

        # Generate the elemental connectivity array using Delaunay triangulation
        FeTopo = Delaunay(FeCoord).simplices

        return FeCoord, FeTopo

def main():
    """
    main entry point
    """
    # Example usage:
    Radius    = 1.0
    NumRadial = 20
    NumTheta  = 20
    NumPhi    = 20

    # Fraction
    # 1/8 of sphere: PhiFraction = 1/4, ThetaFraction = 1/2
    # 1/4 of sphere: PhiFraction = 1/2, ThetaFraction = 1/2
    # 1/2 of sphere: PhiFraction = 1/2, ThetaFraction = 1.0
    # full sphere  : PhiFraction = 1.0, ThetaFraction = 1.0
    PhiFraction   = 1.00 # Fraction of mesh is phi direction, 0 < fraction <= 1
    ThetaFraction = 1.00 # fraction of mesh in theta direction, 0 < fraction <= 1
    mesh = MeshFractionalSphere(Radius, NumRadial, NumTheta, NumPhi, ThetaFraction, PhiFraction)

    # Write into vtk
    cells = [
        ("tetra", mesh.FeTopo),
        ]
    meshio.write_points_cells("sphere_mesh.vtk", mesh.FeCoord, cells)

if __name__ == "__main__":
    """
    Form command lines
    """
    main()
