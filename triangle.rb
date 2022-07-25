# Triangle Project Code.

# Triangle analyzes the lengths of the sides of a triangle
# (represented by a, b and c) and returns the type of triangle.
#
# It returns:
#   :equilateral  if all sides are equal
#   :isosceles    if exactly 2 sides are equal
#   :scalene      if no sides are equal
#
# The tests for this method can be found in
#   about_triangle_project.rb
# and
#   about_triangle_project_2.rb
#
def triangle(a, b, c)
  ### Edge Cases
  ###  1. sides with 0 length
  ###  2. sides with negative length

  raise TriangleError unless not [a,b,c].any? { |num| num <= 0 }

  ### any two sides don't add up to one side
  raise TriangleError unless not (a >= b + c || b >= a + c || c >= a + b)

  if(a == b && b == c) 
    :equilateral
  else
    if(a == b || b == c || a == c)
      :isosceles
    else 
      :scalene
    end 
  end 
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError

end
