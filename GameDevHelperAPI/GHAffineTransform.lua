--creates an identity transform

GHAffineTransform = {}
function GHAffineTransform:create()

		
	local object = {a = 1.0,
					b = 0.0,
					c = 0.0,
                    d = 1.0,
                    tx = 0.0,
                    ty = 0.0
					}

	setmetatable(object, { __index = GHAffineTransform })  -- Inheritance	
	return object
end
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
function GHAffineTransformMake(a, b, c, d, tx, ty)
    
    local t = GHAffineTransform:create()
	t.a = a; 
	t.b = b; 
	t.c = c; 
	t.d = d; 
	t.tx = tx; 
	t.ty = ty;
	return t;
end
--------------------------------------------------------------------------------
function GHAffineTransformMakeIdentity()
    return GHAffineTransformMake(1.0, 0.0, 0.0, 1.0, 0.0, 0.0);
end
--------------------------------------------------------------------------------
function GHAffineTransformTranslate(t, tx, ty)
    return GHAffineTransformMake(t.a, t.b, t.c, t.d, t.tx + t.a * tx + t.c * ty, t.ty + t.b * tx + t.d * ty);
end
--------------------------------------------------------------------------------
function GHAffineTransformRotate(t, anAngle)
    
    local fSin = math.sin(anAngle);
    local fCos = math.cos(anAngle);

    return GHAffineTransformMake(   t.a * fCos + t.c * fSin,
                                    t.b * fCos + t.d * fSin,
                                    t.c * fCos - t.a * fSin,
                                    t.d * fCos - t.b * fSin,
                                    t.tx,
                                    t.ty);
end
--------------------------------------------------------------------------------
function GHPointApplyAffineTransform(pointX, pointY, t)
    
  	local pX = (t.a * pointX + t.c * pointY + t.tx);
  	local pY = (t.b * pointX + t.d * pointY + t.ty);
  	return {x = pX, y = pY};
      
end
--------------------------------------------------------------------------------
