function M = get_cross(vector);
  M = [0, -1*vector(3, 1), vector(2,1); vector(3, 1), 0, -1*vector(1, 1); -1*vector(2, 1), vector(1, 1), 0];

end