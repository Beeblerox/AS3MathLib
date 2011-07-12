package ru.teormech.math.linAlg 
{
	/**
	 * 2-dimensional vector class
	 * @author Zaphod
	 */
	public class Vector2DMath
	{
		/**
		 * horizontal component of the vector
		 */
		private var _x:Number;
		/**
		 * vertical component of the vector
		 */
		private var _y:Number;
		
		public static const EPSILON:Number = 0.0000001;
		public static const EPSILON_SQUARED:Number = EPSILON * EPSILON;
		
		/**
		 * Class constructor
		 * @param	x	horizontal component of the vector
		 * @param	y	vertical component of the vector
		 */
		public function Vector2DMath(x:Number = 0, y:Number = 0)
		{
			_x = x;
			_y = y;
		}
		
		/**
		 * copy of the vector
		 * @return	copy of the vector
		 */
		public function clone():Vector2DMath
		{
			return new Vector2DMath(_x, _y);
		}
		
		/**
		 * scaling of the vector
		 * @param	k - scale coefficient
		 * @return	scaled vector
		 */
		public function scale(k:Number):Vector2DMath
		{
			_x *= k;
			_y *= k;
			return this;
		}
		
		/**
		 * vector addition
		 * @param	v	vector to add
		 * @return	addition result
		 */
		public function add(v:Vector2DMath):Vector2DMath
		{
			_x += v.x;
			_y += v.y;
			return this;
		}
		
		/**
		 * vector substraction
		 * @param	v	vector to substract
		 * @return	substraction result
		 */
		public function substract(v:Vector2DMath):Vector2DMath
		{
			_x -= v.x;
			_y -= v.y;
			return this;
		}
		
		/**
		 * dot product
		 * @param	v	vector to multiply
		 * @return	dot product of two vectors
		 */
		public function dotProduct(v:Vector2DMath):Number
		{
			return _x * v.x + _y * v.y;
		}
		
		/**
		 * dot product of vectors with normalization of the second vector
		 * @param	v	vector to multiply
		 * @return	dot product of two vectors
		 */
		public function dotProdWithNormalizing(v:Vector2DMath):Number
		{
			var normalized:Vector2DMath = v.clone().normalize();
			return _x * normalized.x + _y * normalized.y;
		}
		
		/**
		 * check the perpendicularity of two vectors
		 * @param	v	vector to check
		 * @return	true - if they are perpendicular
		 */
		public function isPerpendicular(v:Vector2DMath):Boolean
		{
			return Math.abs(this.dotProduct(v)) < EPSILON_SQUARED;
		}
		
		/**
		 * cross product
		 * @param	v	vector to multiply
		 * @return	the length of cross product of two vectors
		 */
		public function crossProduct(v:Vector2DMath):Number
		{
			return _x * v.y - _y * v.x;
		}
		
		/**
		 * Check for parallelism of the vectors
		 * @param	v	vector to check
		 * @return	true - if they are parallel
		 */
		public function isParallel(v:Vector2DMath):Boolean
		{
			return Math.abs(this.crossProduct(v)) < EPSILON_SQUARED;
		}
		
		/**
		 * Checking the vector for zero-length
		 * @return	true - if the vector is zero
		 */
		public function isZero():Boolean
		{
			return (Math.abs(_x) < EPSILON && Math.abs(_y) < EPSILON);
		}
		
		/**
		 * Vector reset
		 */
		public function zero():void
		{
			_x = _y = 0;
		}
		
		/**
		 * Normalization of the vector (reduction to unit length)
		 */
		public function normalize():Vector2DMath
		{
			if (isZero()) 
			{
				_x = 1;
				return this;
			}
			return this.scale(1 / this.length);
		}
		
		/**
		 * The horizontal component of the unit vector
		 */
		public function get dx():Number
		{
			if (isZero()) return 0;
			
			return _x / this.length;
		}
		
		/**
		 * The vertical component of the unit vector
		 */
		public function get dy():Number
		{
			if (isZero()) return 0;
			
			return _y / this.length;
		}
		
		/**
		 * Check the vector for unit length
		 */
		public function isNormalized():Boolean
		{
			return Math.abs(lengthSquared - 1) < EPSILON_SQUARED;
		}
		
		/**
		 * Checking for equality of vectors
		 * @return	true - if the vectors are equal
		 */
		public function equals(v:Vector2DMath):Boolean
		{
			return (Math.abs(_x - v.x) < EPSILON && Math.abs(_y - v.y) < EPSILON);
		}
		
		/**
		 * Checking the validity of the vector
		 * @return	true - if the vector is valid
		 */
		public function isValid():Boolean 
		{ 
			return !isNaN(_x) && !isNaN(_y) && isFinite(_x) && isFinite(_y); 
		}
		
		/**
		 * Rotate the vector for a given angle
		 * @param	rads	angle to rotate
		 * @return	rotated vector
		 */
		public function rotate(rads:Number):Vector2DMath
        {
            var s:Number = Math.sin(rads);
            var c:Number = Math.cos(rads);
            var tempX:Number = _x;
			
			_x = tempX * c - _y * s;
			_y = tempX * s + _y * c;
			
			return this;
        }
		
		/**
		 * Rotate the vector vector with the values of sine and cosine of the angle of rotation
		 * @param	sin	the value of sine of the angle of rotation
		 * @param	cos	the value of cosine of the angle of rotation
		 * @return	rotated vector
		 */
		public function rotateWithTrig(sin:Number, cos:Number):Vector2DMath
		{
			var tempX:Number = _x;
			_x = tempX * cos - _y * sin;
			_y = tempX * sin + _y * cos;
			return this;
		}
		
		/**
		 * Right normal of the vector
		 */
		public function get rightNormal():Vector2DMath 
		{ 
			return new Vector2DMath( -_y, _x); 
		}
		
		/**
		 * The horizontal component of the right normal of the vector
		 */
		public function get rx():Number
		{
			return -_y;
		}
		
		/**
		 * The vertical component of the right normal of the vector
		 */
		public function get ry():Number
		{
			return _x;
		}
        
		/**
		 * Left normal of the vector
		 */
		public function get leftNormal():Vector2DMath 
		{ 
			return new Vector2DMath(_y, -_x); 
		}
		
		/**
		 * The horizontal component of the left normal of the vector
		 */
		public function get lx():Number
		{
			return _y;
		}
		
		/**
		 * The vertical component of the left normal of the vector
		 */
		public function get ly():Number
		{
			return -_x;
		}
        
		/**
		 * Change direction of the vector to opposite
		 */
		public function negate():Vector2DMath 
		{ 
			_x *= -1;
			_y *= -1;
			return this;
		}
		
		/**
		 * The projection of this vector to vector that is passed as an argument 
		 * (without modifying the original Vector!)
		 * @param	v	vector to project
		 * @return	projection of the vector
		 */
		public function projectTo(v:Vector2DMath):Vector2DMath
		{
			var dp:Number = this.dotProduct(v);
			var lenSq:Number = v.lengthSquared;
			
			return new Vector2DMath(dp * v.x / lenSq, dp * v.y / lenSq);
		}
		
		/**
		 * Projecting this vector on the normalized vector v
		 * @param	v	this vector has to be normalized, ie have unit length
		 * @return	projection of the vector
		 */
		public function projectToNormalized(v:Vector2DMath):Vector2DMath
		{
			var dp:Number = this.dotProduct(v);
			return new Vector2DMath(dp * v.x, dp * v.y);
		}
		
		/**
		* perproduct - dot product of left the normal vector and vector v
		*/
		public function perpProduct(v:Vector2DMath):Number
		{
			return this.lx * v.x + this.ly * v.y;
		}
		
		/**
		 * Find the ratio between the perpProducts of this vector and v vector. This helps to find the intersection point
		 * @param	a	start point of the vector
		 * @param	b	start point of the v vector
		 * @param	v	the second vector
		 * @return	the ratio between the perpProducts of this vector and v vector
		 */
		public function ratio(a:Vector2DMath, b:Vector2DMath, v:Vector2DMath):Number
		{
			// Убеждаемся, что векторы this и v не параллельны
			if (this.isParallel(v)) return NaN;
			// Убеждаемся, что оба вектора не нулевые
			if (this.lengthSquared < EPSILON_SQUARED || v.lengthSquared < EPSILON_SQUARED) return NaN;
			// Создаем третий вектор, соединяющий точки a и b
			var v3:Vector2DMath = b.clone().substract(a);
			// находим и возвращаем ratio
			return v3.perpProduct(v) / this.perpProduct(v);
		}
		
		/**
		 * Finding the point of intersection of vectors
		 * @param	a	start point of the vector
		 * @param	b	start point of the v vector
		 * @param	v	the second vector
		 * @return the point of intersection of vectors
		 */
		public function findIntersection(a:Vector2DMath, b:Vector2DMath, v:Vector2DMath):Vector2DMath
		{
			var t:Number = this.ratio(a, b, v);
			if (isNaN(t))
			{
				// Векторы не пересекаются
				return new Vector2DMath(NaN, NaN);
			}
			return new Vector2DMath(a.x + t * this.x, a.y + t * this.y);
		}
		
		/**
		 * Finding the point of intersection of vectors if it is in the "bounds" of the vectors
		 * @param	a	start point of the vector
		 * @param	b	start point of the v vector
		 * @param	v	the second vector
		 * @return the point of intersection of vectors if it is in the "bounds" of the vectors
		 */
		public function findIntersectionInBounds(a:Vector2DMath, b:Vector2DMath, v:Vector2DMath):Vector2DMath
		{
			var v4:Vector2DMath = a.clone().substract(b);
			var t1:Number = this.ratio(a, b, v);
			var t2:Number = v.ratio(b, a, this);
			if (!isNaN(t1) && !isNaN(t2) && t1 > 0 && t1 <= 1 && t2 > 0 && t2 <= 1)
			{
				return new Vector2DMath(a.x + t1 * this.x, a.y + t1 * this.y);
			}
			return new Vector2DMath(NaN, NaN);
		}
		
		/**
		 * Length limit of the vector
		 * @param	max	maximum length of this vector
		 */
		public function truncate(max:Number):Vector2DMath
		{
			this.length = Math.min(max, this.length);
			return this;
		}
		
		/**
		 * The angle between vectors
		 * @param	v	second vector, which we find the angle
		 * @return	the angle in radians
		 */
		public function angleBetween(v:Vector2DMath):Number
		{
			var v1:Vector2DMath = this.clone();
			var v2:Vector2DMath = v.clone();
			if (!this.isNormalized())
			{
				v1.normalize();
			}
			if (!v.isNormalized())
			{
				v2.normalize();
			}
			return Math.acos(v1.dotProduct(v2));
		}
		
		/**
		 * Set both components of the vectorat once 
		 * @param	a	horizontal component of the vector
		 * @param	b	vertical component of the vector
		 */
		public function setXY(a:Number, b:Number):void
		{
			_x = a;
			_y = b;
		}
		
		/**
		 * The sign of half-plane of point with respect to the vector through the a and b points
		 * @param	a	start point of the wall-vector
		 * @param	b	end point of the wall-vector
		 */
		public function sign(a:Vector2DMath, b:Vector2DMath):int
		{
			return (a.x - this.x) * (b.y - this.y) - (a.y - this.y) * (b.x - this.x);
		}
		
		/**
		 * The distance between points
		 */
		public function dist(v:Vector2DMath):Number
		{
			return Math.sqrt(distSquared(v));
		}
		
		/**
		 * The squared distance between points
		 */
		public function distSquared(v:Vector2DMath):Number
		{
			var dx:Number = v.x - _x;
			var dy:Number = v.y - _y;
			return (dx * dx + dy * dy);
		}
		
		/**
         * Reflect the vector with respect to the normal of the "wall"
		 * @param normal left normal of the "wall". It must be normalized (no checks)
		 * @param bounceCoeff bounce coefficient (0 <= bounceCoeff <= 1)
		 * @return reflected vector (angle of incidence equals to angle of reflection)
         */
        public function bounce(normal:Vector2DMath, bounceCoeff:Number = 1):Vector2DMath
        {
			var d:Number = (1 + bounceCoeff) * this.dotProduct(normal);
            _x -= d * normal.x;
			_y -= d * normal.y;
			return this;
        }
		
		/**
         * Reflect the vector with respect to the normal. This operation takes "friction" into account
		 * @param normal left normal of the "wall". It must be normalized (no checks)
		 * @param bounceCoeff bounce coefficient (0 <= bounceCoeff <= 1)
		 * @param friction friction coefficient
		 * @return reflected vector
         */
		public function bounceWithFriction(normal:Vector2DMath, bounceCoeff:Number = 1, friction:Number = 0):Vector2DMath
		{
			var v1:Vector2DMath = this.clone();
			var p1:Vector2DMath = this.projectToNormalized(normal.rightNormal);
			var p2:Vector2DMath = this.projectToNormalized(normal);
			var bounceX:Number = -p2.x;
			var bounceY:Number = -p2.y;
			var frictionX:Number = p1.x;
			var frictionY:Number = p1.y;
			this.x = bounceX * bounceCoeff + frictionX * friction;
			this.y = bounceY * bounceCoeff + frictionY * friction;
			return this;
		}
		
		/**
		 * horizontal projection of the vector
		 */
		public function get x():Number { return _x; }
		
		public function set x(value:Number):void 
		{
			_x = value;
		}
		
		/**
		 * vertical projection of the vector
		 */
		public function get y():Number { return _y; }
		
		public function set y(value:Number):void 
		{
			_y = value;
		}
		
		/**
		 * Length of the vector
		 */
		public function get length():Number
		{
			return Math.sqrt(_x * _x + _y * _y);
		}
		
		public function set length(l:Number):void
		{
			var a:Number = this.angle;
			_x = l * Math.cos(a);
			_y = l * Math.sin(a);
		}
		
		/**
		 * length of the vector squared
		 */
		public function get lengthSquared():Number
		{
			return _x * _x + _y * _y;
		}
		
		/**
		 * The angle formed by the vector with the horizontal axis
		 */
		public function get angle():Number
		{
			if (isZero()) return 0;
			
			return Math.atan2(_y, _x);
		}
		
		public function set angle(rads:Number):void
		{
			var len:Number = this.length;
			_x = len * Math.cos(rads);
			_y = len * Math.sin(rads);
		}
		
		public function toString():String 
		{ 
			return "[" + _x + ", " + _y + "]"; 
		}
		
	}
	
}