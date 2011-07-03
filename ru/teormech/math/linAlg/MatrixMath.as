package ru.teormech.math.linAlg 
{
	/**
	 * ...
	 * @author Zaphod
	 */
	public class MatrixMath
	{
		
		// TODO: Задокументировать класс
		// TODO: Перенести в другой пакет
		// TODO: Примеры вызова методов
		/**
		 * Matrix array holder
		 */
		protected var _m:Vector.<Number>;
		/**
		 * Error flag
		 */
		private var _isError:Boolean;
		/**
		 * Error message holder
		 */
		private var _errorMes:String;
		/**
		 * Helper variable. Used for calculation of determinant
		 */
		private var _det:Number;
		/**
		 * Number of rows of this matrix
		 */
		private var _rows:uint;
		/**
		 * Number of columns of this matrix
		 */
		private var _columns:uint;
		
		/**
		 * Class Constructor
		 * @param	rows number of rows of matrix
		 * @param	cols number of columns of matrix
		 */
		public function MatrixMath(rows:uint, cols:uint) 
		{
			_m = new Vector.<Number>();
			
			_rows = rows;
			_columns = cols;
			
			var numElements:uint = rows * cols;
			for (var i:int = 0; i < numElements; i++)
			{
				_m.push(0);
			}
			
			_isError = false;
			_errorMes = "";
		}
		
		/**
		 * Defines this instance as an identity matrix
		 */
		public function identity():void 
		{
			_isError = false;
			_errorMes = "";
			
			if (_rows != _columns)
			{
				_isError = true;
				_errorMes = "Number of rows doesn't match number of columns";
				return;
			}
			
			for (var i:int = 0; i < _rows; i++) 
			{
				for (var j:int = 0; j < _columns; j++) 
				{
					if (i == j) _m[j + i * _columns] = 1;
					else _m[j + i * _columns] = 0;
				}
			}
		}
		
		/**
		 * Matrices multiplication. 
		 * Resets this instance's _m property with the multiplication results 
		 * of this Matrix object and the passed Matrix object.
		 * Number of columns of this matrix must be equal to number of rows of the second matrix.
		 * Otherwise there will be error.
		 * @param	m2 matrix-multiplier
		 */
		public function multiply(m2:MatrixMath):void
		{
			_isError = false;
			_errorMes = "";
			
			if (_columns != m2.rows)
			{
				_isError = true;
				_errorMes = "Number of columns of the first matrix doesn't match with number of rows of the second matrix";
				return;
			}
			
			var m2NumCols2:int = m2.columns;
			var tempMatr:MatrixMath = new MatrixMath(_rows, m2NumCols2);
			for (var i:int = 0; i < _rows; i++) 
			{
				for (var j:int = 0; j < m2NumCols2; j++) 
				{
					for (var k:int = 0; k < _columns; k++) 
					{
						tempMatr._m[j + i * m2NumCols2] += this._m[k + i * _columns] * m2._m[j + k * m2NumCols2];
					}
				}
			}
			
			this._columns = m2NumCols2;
			this._m = tempMatr._m;
		}
		
		/**
		 * Scalar multiplication
		 * Scales this instance's _m elements by the passed value.
		 */
		public function scalar(s:Number):void 
		{
			var numElements:uint = _rows * _columns;
			for (var i:int = 0; i < numElements; i++) 
			{
				_m[i] *= s;
			}
		}
		
		/**
		 * Maxtrix addition.
		 * Resets this instance's _m property with the addition results 
		 * of this Matrix object and the passed Matrix object.
		 * Numbers of columns and rows of this matrix must be equal to numbers of columns and rows of the second matrix.
		 * Otherwise there will be error.
		 * @param	m2 matrix to add
		 */
		public function add(m2:MatrixMath):void
		{
			_isError = false;
			_errorMes = "";
			
			if (_rows != m2.rows || _columns != m2.columns)
			{
				_isError = true;
				_errorMes = "Number of columns and rows of the first matrix doesn't match with number of columns and rows of the second matrix";
				return;
			}
			
			var numElements:uint = _rows * _columns;
			for (var i:int = 0; i < numElements; i++) 
			{
				_m[i] += m2._m[i];
			}
		}
		
		/**
		 * Maxtrix substraction.
		 * Resets this instance's _m property with the substraction results 
		 * of this Matrix object and the passed Matrix object.
		 * Numbers of columns and rows of this matrix must be equal to numbers of columns and rows of the second matrix.
		 * Otherwise there will be error.
		 * @param	m2 matrix to substract
		 */
		public function substract(m2:MatrixMath):void
		{
			_isError = false;
			_errorMes = "";
			
			if (_rows != m2.rows || _columns != m2.columns)
			{
				_isError = true;
				_errorMes = "Number of columns and rows of the first matrix doesn't match with number of columns and rows of the second matrix";
				return;
			}
			
			var numElements:uint = _rows * _columns;
			for (var i:int = 0; i < numElements; i++) 
			{
				_m[i] -= m2._m[i];
			}
		}
		
		/**
		 * Transpose this Matrix object
		 */
		public function transpose():void
		{
			var tempMatr:MatrixMath = new MatrixMath(_columns, _rows);
			for (var i:int = 0; i < _rows; i++) 
			{
				for (var j:int = 0; j < _columns; j++) 
				{
					tempMatr._m[i + j * _rows] = this._m[j + i * _columns];
				}
			}
			this._m = tempMatr._m;
		}
		
		/**
		 * Gaussian elimination process. Will transform this matrix to upper triangular matrix.
		 */
		public function gaussElimination():void
		{
			_isError = false;
			_errorMes = "";
			
			var pivotRow:int;
			var temp:Number;
			_det = 1;
			
			if (_rows > _columns - 1)
			{
				_isError = true;
				_errorMes = "This matrix doesn't represent any system of equations";
				return;
			}
			
			for (var i:int = 0; i < _rows - 1; i++)
			{
				pivotRow = i;
				for (var j:int = i + 1; j < _rows; j++)
				{
					if (Math.abs(_m[i + j * _columns]) > Math.abs(_m[i + pivotRow * _columns]))
					{
						pivotRow = j;
					}
				}
				swapRows(i, pivotRow);
				for (j = i + 1; j < _rows; j++)
				{
					if (_m[i * (1 + _columns)] == 0) 
					{
						_isError = true;
						_errorMes = "This system of equations doesn't have any solution";
						return;
					}
					
					temp = _m[i + j * _columns] / _m[i * (1 + _columns)];
					for (var k:int = i; k < _columns; k++)
					{
						_m[k + j * _columns] -= _m[k + i * _columns] * temp;
					}
				}
			}
			
			if (_m[(_rows - 1) * (1 + _columns)] == 0) 
			{
				_isError = true;
				_errorMes = "This system of equations doesn't have any solution";
				return;
			}
		}
		
		/**
		 * Gaussian method for solving systems of linear equations.
		 * @param	A matrix with variable's coefficients
		 * @param	B matrix-row with free coefficients
		 * @return matrix-row which contains values of variables
		 */
		public static function GaussSolution(A:MatrixMath, B:MatrixMath):MatrixMath
		{
			var numRows:int = A.rows;
			var sum:Number;
			// Матрица-столбец решения
			var x:MatrixMath = new MatrixMath(numRows, 1);
			
			if (A.rows != A.columns || A.rows != B.rows || B.columns > 1 || B.columns == 0) 
			{
				x.resize(0, 0);
				x.isError = true;
				x.errorMes = "Can't solve this system of equations";
				return x;
			}
			
			// Создание новой матрицы для преобразования к верхнетреугольному виду
			var tempMatr:MatrixMath = A.merge(B);
			var tempMatrCols:int = tempMatr.columns;
			// Прямой ход метода Гаусса
			tempMatr.gaussElimination();
			if (tempMatr.isError) 
			{
				x.resize(0, 0);
				x.isError = true;
				x.errorMes = tempMatr.errorMes;
				return x;
			}
			
			// Обратный ход метода Гаусса
			for (var i:int = numRows - 1; i >= 0; i--)
			{
				sum = 0;
				for (var j:int = i + 1; j < numRows; j++)
				{
					sum += tempMatr._m[j + i * tempMatrCols] * x._m[j];
				}
				x._m[i] = (tempMatr._m[numRows + i * tempMatrCols] - sum) / tempMatr._m[i * (1 + tempMatrCols)];
			}
			
			return x;
		}
		
		/**
		 * Inverse Matrix Calculation
		 * @return Iverted Matrix
		 */
		public function inverse():MatrixMath
		{
			_isError = false;
			_errorMes = "";
			var numRows:int = rows;
			var I:MatrixMath = new MatrixMath(numRows, numRows);
			
			if (_rows != _columns) 
			{
				I.resize(0, 0);
				I.isError = true;
				I.errorMes = "Number of rows doesn't match number of columns";;
				return I;
			}
			
			var sum:Number;
			var A:MatrixMath = merge(I);
			var numCols:int = A.columns;
			
			for (var i:int = 0; i < numRows; i++)
			{
				A._m[(i + numRows) + i * numCols] = 1;
			}
			
			A.gaussElimination();
			if (A.isError) {
				I.resize(0, 0);
				I.isError = true;
				I.errorMes = A.errorMes;
				return I;
			}
			
			for (var column:int = 0; column < numRows; column++)
			{
				for (i = numRows - 1; i >= 0; i--)
				{
					sum = 0;
					for (var j:int = i + 1; j < numRows; j++)
					{
						sum += A._m[j + i * numCols] * I._m[column + j * numRows];
					}
					I._m[column + i * numRows] = (A._m[column + numRows + i * numCols] - sum) / A._m[i * (1 + numCols)];
				}
			}
			
			return I;
		}
		
		/**
		 * Calculation of the determinant of this matrix with Gaussian elimination method. Matrix must be square.
		 * @return determinant value
		 */
		public function gaussDeterminant():Number
		{
			_isError = false;
			_errorMes = "";
			
			if (rows != columns) 
			{
				_isError = true;
				_errorMes = "Number of rows doesn't match number of columns";
				return NaN;
			}
			
			var numRows:int = rows;
			var A:MatrixMath = this.merge(new MatrixMath(numRows, 1));
			A.gaussElimination();
			if (A.isError) 
			{
				_isError = true;
				_errorMes = "Some unexpected error";
				return 0;
			}
			
			_det = A.detMultiplier;
			var Acols:int = A.columns;
			for (var i:int = 0; i < numRows; i++)
			{
				_det *= A._m[i * (1 + Acols)];
			}
			
			return _det;
		}
		
		/**
		 * Calculation of the determinant of this matrix with recursive method.
		 * This method is very processor-intensive, and not recommended for use with matrices over 8x8 elements
		 * @return determinant value
		 */
		public function recursiveDeterminant():Number
		{
			_isError = false;
			_errorMes = "";
			
			if (rows != columns) 
			{
				_isError = true;
				_errorMes = "Number of rows doesn't match number of columns";
				return NaN;
			}
			
			var numRows:int = rows;
			var det:Number = 0;
			var part1:MatrixMath;
			var part2:MatrixMath;
			var tempMatr:MatrixMath;
			var mult:int;
			var element:Number;
			
			if (numRows > 1)
			{
				for (var i:int = 0; i < numRows; i++)
				{
					element = _m[i];
					if (element != 0)
					{
						(i % 2 == 0) ? mult = 1 : mult = -1;
						
						if (i == 0) 
						{
							tempMatr = fragment(1, 1, numRows - 1, columns - 1);
						}
						else if (i == numRows - 1)
						{
							tempMatr = fragment(1, 0, numRows - 1, columns - 2);
						}
						else
						{
							part1 = fragment(1, 0, numRows - 1, i - 1);
							part2 = fragment(1, i + 1, numRows - 1, columns - 1);
							tempMatr = part1.merge(part2);
						}
						
						det += mult * element * tempMatr.recursiveDeterminant();
					}
				}
			}
			else
			{
				det = _m[0];
			}
			
			return det;
		}
		
		/**
		 * LUP Decomposition method for solving systems of linear equations. 
		 * @param	A matrix with variable's coefficients
		 * @param	P permutation matrix-row
		 */
		public static function LUPDecomposition(A:MatrixMath, P:MatrixMath):void
		{
			if (A.rows != A.columns) return;
			var numRows:int = A.rows;
			P.resize(numRows, 1);
			for (var i:int = 0; i < numRows; i++)
			{
				P._m[i] = i;
			}
			for (var k:int = 0; k < numRows; k++)
			{
				var p:Number = 0;
				var kk:int;
				for (i = k; i < numRows; i++)
				{
					if (Math.abs(A._m[k + i * numRows]) > p)
					{
						p = Math.abs(A._m[k + i * numRows]);
						kk = i;
					}
				}
				
				if (p == 0) 
				{
					A.isError = true;
					A.errorMes = "Can't solve this system of equations";
					return;
				}
				P.swapRows(k, kk);
				A.swapRows(k, kk);
				for (i = k + 1; i < numRows; i++)
				{
					A._m[k + i * numRows] /= A._m[k * (1 + numRows)];
					for (var j:int = k + 1; j < numRows; j++)
					{
						A._m[j + i * numRows] -= A._m[k + i * numRows] * A._m[j + k * numRows];
					}
				}
			}
		}
		
		/**
		 * LUP Solution method for solving systems of linear equations. Must be used after LUP Decomposition method
		 * @param	A matrix with variable's coefficients after decomposition
		 * @param	P permutation matrix-row after decomposition
		 * @param	B matrix-row with free coefficients of this system of linear equations
		 * @return matrix-row which contains values of variables
		 */
		public static function LUPSolution(A:MatrixMath, P:MatrixMath, B:MatrixMath):MatrixMath
		{
			var numRows:int = A.rows;
			var sum:Number;
			var i:int, j:int;
			var x:MatrixMath = new MatrixMath(numRows, 1);
			if (A.isError || numRows != A.columns || numRows != P.rows || P.columns != 1 || numRows != B.rows || B.columns != 1) 
			{
				x.resize(0, 0);
				x.isError = true;
				x.errorMes = "Can't solve this system of equations";
				return x;
			}
			
			for (i = 0; i < numRows; i++)
			{
				sum = 0;
				for (j = 0; j < i; j++)
				{
					sum += A._m[j + i * numRows] * x._m[j];
				}
				x._m[i] = B._m[P._m[i]] - sum;
			}
			
			for (i = numRows - 1; i >= 0; i--)
			{
				sum = 0;
				for (j = i + 1; j < numRows; j++)
				{
					sum += A._m[j + i * numRows] * x._m[j];
				}
				x._m[i] = (x._m[i] - sum) / A._m[i * (1 + numRows)];
			}
			
			return x;
		}
		
		/**
		 * Cramer's method for solving systems of linear equations.
		 * This method is very processor-intensive, and not recommended for use with matrices over 8x8 elements
		 * @param	A matrix with variable's coefficients
		 * @param	B matrix-row with free coefficients
		 * @return matrix-row which contains values of variables
		 */
		public static function CramerSolution(A:MatrixMath, B:MatrixMath):MatrixMath
		{
			var numRows:int = A.rows;
			// Матрица-столбец решения
			var x:MatrixMath = new MatrixMath(numRows, 1);
			var tempMatr:MatrixMath;
			
			if (A.rows != A.columns || A.rows != B.rows || B.columns != 1) 
			{
				x.resize(0, 0);
				x.isError = true;
				x.errorMes = "Can't solve this system of equations";
				return x;
			}
			
			var detA:Number = A.recursiveDeterminant();
			if (detA == 0)
			{
				x.resize(0, 0);
				x.isError = true;
				x.errorMes = "The A matrix is not invertible. So I can't solve this system of equations";
				return x;
			}
			else
			{
				for (var i:int = 0; i < numRows; i++)
				{
					tempMatr = A.clone();
					tempMatr.insert(B, 0, i);
					x._m[i] = tempMatr.recursiveDeterminant() / detA;
				}
			}
			
			return x;
		}
		
		/**
		 * Insertion of matrix in specified position of this matrix
		 * @param	mat matrix to insert
		 * @param	row row-position to insert the matrix
		 * @param	col column-position to insert the matrix
		 * @param	resize resize flag. Matrix size will be enhanced (when there is such need) if this parameter is true
		 */
		public function insert(mat:MatrixMath, row:uint = 0, col:uint = 0, resize:Boolean = false):void
		{
			var oldRows:int = rows;
			var oldCols:int = columns;
			
			if (row >= oldRows || col >= oldCols) return;
			
			var newRows:int = row + mat.rows;
			var newCols:int = col + mat.columns;
			newRows = (newRows > oldRows) ? newRows : oldRows;
			newCols = (newCols > oldCols) ? newCols : oldCols;
			if (resize)
			{
				this.resize(newRows, newCols);
			}
			// Вставка значений из вставляемой матрицы
			newRows = row + mat.rows;
			newCols = col + mat.columns;
			var maxRow:int = (newRows <= rows) ? newRows : rows;
			var maxCol:int = (newCols <= columns) ? newCols : columns;
			for (var i:int = row; i < maxRow; i++)
			{
				for (var j:int = col; j < maxCol; j++)
				{
					_m[j + i * _columns] = mat._m[(j - col) + (i - row) * mat.columns];
				}
			}
		}
		
		/**
		 * Matrix resize method
		 * @param	newRows new number of rows of this matrix
		 * @param	newCols new number of columns of this matrix
		 */
		public function resize(newRows:uint, newCols:uint):void
		{
			var oldRows:int = rows;
			var oldCols:int = columns;
			var tempMatr:MatrixMath = new MatrixMath(newRows, newCols);
			var i:int, j:int;
			
			for (i = 0; i < newRows; i++)
			{
				if (i < oldRows)
				{
					for (j = 0; j < newCols; j++)
					{
						if (j < oldCols)
						{
							tempMatr._m[j + i * newCols] = this._m[j + i * oldCols];
						}
					}
				}
			}
			_rows = newRows;
			_columns = newCols;
			this._m = tempMatr._m;
		}
		
		/**
		 * Copy some fragment of this matrix
		 */
		public function fragment(startRow:uint, startCol:uint, endRow:uint, endCol:uint):MatrixMath
		{
			if (startRow > _rows) startRow = _rows;
			if (startCol > _columns) startCol = _columns;
			if (endRow > _rows) endRow = _rows;
			if (endCol > _columns) endCol = _columns;
			
			var tempNum:uint;
			if (startRow > endRow)
			{
				tempNum = startRow;
				startRow = endRow;
				endRow = tempNum;
			}
			if (startCol > endCol)
			{
				tempNum = startCol;
				startCol = endCol;
				endCol = tempNum;
			}
			
			var tempMatrCols:int = endCol - startCol + 1;
			var tempMatr:MatrixMath = new MatrixMath(endRow - startRow + 1, tempMatrCols);
			for (var i:int = startRow; i <= endRow; i++) 
			{
				for (var j:int = startCol; j <= endCol; j++) 
				{
					tempMatr._m[j - startCol + (i - startRow) * tempMatrCols] = _m[j + i * _columns];
				}
			}
			return tempMatr;
		}
		
		/**
		 * Merge this matrix with matrix m2
		 * @param	m2 matrix to merge
		 * @return merged matrix
		 */
		public function merge(m2:MatrixMath):MatrixMath
		{
			var secondRows:int = m2.rows;
			var secondCols:int = m2.columns;
			var firstRows:int = _rows;
			var firstCols:int = _columns;
			
			var tempMatrCols:int = firstCols + secondCols;
			var tempMatr:MatrixMath = new MatrixMath(Math.max(firstRows, secondRows), tempMatrCols);
			
			for (var i:int = 0; i < firstRows; i++) 
			{
				for (var j:int = 0; j < firstCols; j++) 
				{
					tempMatr._m[j + i * tempMatrCols] = this._m[j + i * firstCols];
				}
			}
			
			for (i = 0; i < secondRows; i++) 
			{
				for (j = 0; j < secondCols; j++) 
				{
					tempMatr._m[j + firstCols + i * tempMatrCols] = m2._m[j + i * secondCols];
				}
			}
			
			return tempMatr;
		}
		
		/**
		 * Swap two rows of this matrix
		 */
		public function swapRows(row1:uint, row2:uint):void
		{
			if (row1 > _rows || row2 > _rows) return;
			
			if (row1 != row2)
			{
				_det = -_det;
				var tempNum:Number;
				for (var j:int = 0; j < _columns; j++) 
				{
					tempNum = _m[j + row1 * _columns];
					_m[j + row1 * _columns] = _m[j + row2 * _columns];
					_m[j + row2 * _columns] = tempNum;
				}
			}
		}
		
		/**
		 * Defines each matrix element as a random number clamped between passed min-max values.
		 */
		public function random(a:Number, b:Number):void 
		{
			var numElements:int = _rows * _columns;
			for (var i:int = 0; i < numElements; i++) 
			{
				_m[i] = Math.round(Math.random() * (Math.max(a, b) - Math.min(a, b))) + Math.min(a, b);
			}
		}
		
		/**
		 * Copy this matrix
		 */
		public function clone():MatrixMath
		{
			var numElements:uint = _rows * _columns;
			var tempMatr:MatrixMath = new MatrixMath(_rows, _columns);
			for (var i:int = 0; i < numElements; i++) 
			{
				tempMatr._m[i] = this._m[i];
			}
			return tempMatr;
		}
		
		public function get isError():Boolean { return _isError; }
		
		public function get errorMes():String { return _errorMes; }
		
		public function get detMultiplier():Number { return _det; }
		
		public function get rows():int { return _rows; }
		
		public function get columns():int { return _columns; }
		
		public function set isError(value:Boolean):void 
		{
			_isError = value;
		}
		
		public function set errorMes(value:String):void 
		{
			_errorMes = value;
		}
		
		/**
		 * Sets the element with specified value
		 */
		public function setElement(row:uint, col:uint, value:Number):void
		{
			if (row >= _rows || col >= _columns) return;
			_m[col + row * _columns] = value;
		}
		
		/**
		 * Gets the value of specified element
		 */
		public function getElement(row:uint, col:uint):Number
		{
			if (row >= _rows || col >= _columns) return NaN;
			return _m[col + row * _columns];
		}
		
		/**
		 * Sets the Matrix Object properties from two-dimensional Vector
		 */
		public function setMatrixFromRows(rowsVector:Vector.<Vector.<Number>>):void
		{
			var numRows:int = rowsVector.length;
			var numCols:int = rowsVector[0].length;
			for (var i:int = 0; i < numRows; i++)
			{
				if (rowsVector[i].length != numCols) return;
			}
			
			_m.length = numRows * numCols;
			for (i = 0; i < numRows; i++)
			{
				for (var j:int = 0; j < numCols; j++)
				{
					_m[j + i * numCols] = rowsVector[i][j];
				}
			}
			_rows = numRows;
			_columns = numCols;
		}
		
		/**
		 * Sets the Matrix Object properties from one-dimensional Vector and numbers of rows and columns
		 */
		public function setMatrixFromVector(matrixVector:Vector.<Number>, numRows:uint, numCols:uint):void
		{
			var numElements:uint = numRows * numCols;
			if (numElements != matrixVector.length) return;
			for (var i:int = 0; i < numElements; i++)
			{
				_m[i] = matrixVector[i];
			}
			_rows = numRows;
			_columns = numCols;
		}
		
		/**
		 * Gets the Matrix m property - Vector which contains all alements of the matrix
		 */
		public function get m():Vector.<Number> { return _m; }
		
		/**
		 * Used for debugging -- traces the Matrix object.
		 */
		public function traceMatrix():void
		{
			var row:String;
			for (var i:int = 0; i < _rows; i++)
			{
				row = "";
				for (var j:int = 0; j < _columns; j++)
				{
					row += _m[j + i * _columns];
					if (j < _columns - 1) row += "\t";
				}
				trace(row);
			}
		}
		
	}

}