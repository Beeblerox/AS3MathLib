package  
{
	import flash.display.Sprite;
	import ru.teormech.math.linAlg.MatrixMath;
	
	/**
	 * ...
	 * @author Zaphod
	 */
	public class MatrixSampleClass extends Sprite
	{
		
		public var testMatr:MatrixMath;
		public var testMatr1:MatrixMath;
		public var testMatr2:MatrixMath;
		
		public function MatrixSampleClass() 
		{
			identityTest(3);
			randomMatrixTest(3);
			multiplyTest(3);
			scalarTest(3);
			additionTest(2, 4);
			substractionTest(2, 4);
			transposeTest(2, 4);
			solutionMethodsTest(3);
			determinantTest(3);
			inverseTest(3);
		}
		
		public function identityTest(numRows:uint):void
		{
			testMatr = new MatrixMath(numRows, numRows);
			testMatr.identity();
			trace("");
			trace("Identity method test:");
			testMatr.traceMatrix();
		}
		
		public function randomMatrixTest(numRows:uint):void
		{
			testMatr = new MatrixMath(numRows, numRows);
			testMatr.random(0, 100);
			trace("");
			trace("Random method test:");
			testMatr.traceMatrix();
		}
		
		public function multiplyTest(numRows:uint):void
		{
			trace("");
			trace("Multiply method test:");
			testMatr1 = new MatrixMath(numRows, numRows);
			testMatr1.random(0, 10);
			trace("A:");
			testMatr1.traceMatrix();
			testMatr2 = new MatrixMath(numRows, numRows);
			testMatr2.random(0, 10);
			trace("B:");
			testMatr2.traceMatrix();
			testMatr1.multiply(testMatr2);
			trace("AxB:");
			testMatr1.traceMatrix();
		}
		
		public function scalarTest(numRows:uint):void
		{
			testMatr = new MatrixMath(numRows, numRows);
			testMatr.random(0, 100);
			var randomNum:int = int(100 * Math.random());
			trace("");
			trace("Scalar multiplication test:");
			trace("A:");
			testMatr.traceMatrix();
			trace(randomNum + "*A:");
			testMatr.scalar(randomNum);
			testMatr.traceMatrix();
		}
		
		public function additionTest(numRows:uint, numCols:uint):void
		{
			trace("");
			trace("Matrix addition test:");
			testMatr1 = new MatrixMath(numRows, numCols);
			testMatr1.random(0, 10);
			trace("A:");
			testMatr1.traceMatrix();
			testMatr2 = new MatrixMath(numRows, numCols);
			testMatr2.random(0, 10);
			trace("B:");
			testMatr2.traceMatrix();
			testMatr1.add(testMatr2);
			trace("A+B:");
			testMatr1.traceMatrix();
		}
		
		public function substractionTest(numRows:uint, numCols:uint):void
		{
			trace("");
			trace("Matrix substraction test:");
			testMatr1 = new MatrixMath(numRows, numCols);
			testMatr1.random(0, 10);
			trace("A:");
			testMatr1.traceMatrix();
			testMatr2 = new MatrixMath(numRows, numCols);
			testMatr2.random(0, 10);
			trace("B:");
			testMatr2.traceMatrix();
			testMatr1.substract(testMatr2);
			trace("A+B:");
			testMatr1.traceMatrix();
		}
		
		public function transposeTest(numRows:uint, numCols:uint):void
		{
			testMatr = new MatrixMath(numRows, numRows);
			testMatr.random(0, 100);
			trace("");
			trace("Transpose Matrix method test:");
			trace("Original matrix:");
			testMatr.traceMatrix();
			testMatr.transpose();
			trace("Transposed matrix:");
			testMatr.traceMatrix();
		}
		
		public function solutionMethodsTest(numRows:uint):void
		{
			trace("Solution Methods Test:");
			
			testMatr1 = new MatrixMath(numRows, numRows);
			testMatr1.random(0, 100);
			trace("A:");
			testMatr1.traceMatrix();
			testMatr2 = new MatrixMath(numRows, 1);
			testMatr2.random(0, 50);
			trace("B:");
			testMatr2.traceMatrix();
			
			trace("Cramer Solution:");
			testMatr = MatrixMath.CramerSolution(testMatr1, testMatr2);
			trace(testMatr.m);
			
			trace("Gauss Solution");
			testMatr = MatrixMath.GaussSolution(testMatr1, testMatr2);
			trace(testMatr.m);
			trace("LUP Solution");
			var permutationMatr:MatrixMath = new MatrixMath(testMatr1.rows, 1);
			MatrixMath.LUPDecomposition(testMatr3, testMatr1);
			testMatr = MatrixMath.LUPSolution(testMatr1, testMatr1, testMatr2);
			trace(testMatr.m);
		}
		
		public function determinantTest(numRows:uint):void
		{
			testMatr = new MatrixMath(numRows, numRows);
			testMatr.random(0, 100);
			trace("");
			trace("Determinant Calculation Test:");
			trace("A:");
			testMatr.traceMatrix();
			trace("Gauss method result:");
			trace(testMatr.gaussDeterminant());
			trace("Recursive method result:");
			trace(testMatr.recursiveDeterminant());
		}
		
		public function inverseTest(numRows:uint):void
		{
			testMatr = new MatrixMath(numRows, numRows);
			testMatr.random(0, 100);
			trace("");
			trace("Inverse Matrix Calculation Test:");
			trace("A:");
			testMatr.traceMatrix();
			trace("I:");
			testMatr1 = testMatr.inverse();
			testMatr1.traceMatrix();
		}
		
	}

}