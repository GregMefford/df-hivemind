def unit_is_leader?(unit)
  df.unit_entitypositions(unit).each do |position|
    return true if position.flags[:IS_LEADER]
  end
  return false
end

def unit_find_leader
  df.world.units.all.find{|unit| unit_is_leader?(unit) }
end

def map_dig_rect(x1, y1, z1, x2, y2, z2, mode=:Default)
  (z1..z2).each do |z|
    (y1..y2).each do |y|
      (x1..x2).each do |x|
        df.map_tile_at(x, y, z).dig(mode)
      end
    end
  end
end

def map_dig_basic_fort(x, y, z)
  # Surface Access
  map_dig_rect(x-1, y-2, z  , x+1, y-2, z  , :Channel)

  # Entryway
  map_dig_rect(x-1, y-1, z-1, x+1, y+5, z-1)

  # Main Ramp
  map_dig_rect(x-1, y+6 , z-1, x+1, y+6 , z-1, :Channel)
  map_dig_rect(x-1, y+7 , z-2, x+1, y+7 , z-2, :Channel)
  map_dig_rect(x-1, y+8 , z-3, x+1, y+8 , z-3, :Channel)
  map_dig_rect(x-1, y+9 , z-4, x+1, y+9 , z-4, :Channel)
  map_dig_rect(x-1, y+10, z-5, x+1, y+10, z-5, :Channel)

  # Main Hallway
  map_dig_rect(x-1, y-24, z-6, x+1, y-15, z-6)
  map_dig_rect(x-1, y-1 , z-6, x+1, y+9 , z-6)

  # Meeting Hall
  map_dig_rect(x  , y-14, z-6, x  , y-14, z-6)
  map_dig_rect(x-5, y-13, z-6, x+5, y-3 , z-6)
  map_dig_rect(x  , y-2 , z-6, x  , y-2 , z-6)

  # Eight Bedrooms
  map_dig_rect(x-2, y-23, z-6, x-2, y-23, z-6) # Door
  map_dig_rect(x-7, y-25, z-6, x-3, y-21, z-6) # 5x5 Room

  map_dig_rect(x-2, y-17, z-6, x-2, y-17, z-6) # Door
  map_dig_rect(x-7, y-19, z-6, x-3, y-15, z-6) # 5x5 Room

  map_dig_rect(x-2, y+1 , z-6, x-2, y+1 , z-6) # Door
  map_dig_rect(x-7, y-1 , z-6, x-3, y+3 , z-6) # 5x5 Room

  map_dig_rect(x-2, y+7 , z-6, x-2, y+7 , z-6) # Door
  map_dig_rect(x-7, y+5 , z-6, x-3, y+9 , z-6) # 5x5 Room

  map_dig_rect(x+2, y-23, z-6, x+2, y-23, z-6) # Door
  map_dig_rect(x+3, y-25, z-6, x+7, y-21, z-6) # 5x5 Room

  map_dig_rect(x+2, y-17, z-6, x+2, y-17, z-6) # Door
  map_dig_rect(x+3, y-19, z-6, x+7, y-15, z-6) # 5x5 Room

  map_dig_rect(x+2, y+1 , z-6, x+2, y+1 , z-6) # Door
  map_dig_rect(x+3, y-1 , z-6, x+7, y+3 , z-6) # 5x5 Room

  map_dig_rect(x+2, y+7 , z-6, x+2, y+7 , z-6) # Door
  map_dig_rect(x+3, y+5 , z-6, x+7, y+9 , z-6) # 5x5 Room
end

leader = unit_find_leader
x, y, z = leader.pos.x, leader.pos.y, leader.pos.z

map_dig_basic_fort(x, y, z)
