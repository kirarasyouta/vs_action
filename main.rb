require 'dxruby'

Window.width = 1920
Window.height = 1200
Window.windowed = false

walls = [
  Sprite.new(0, 0, Image.new(20, 1200, C_WHITE)),
  Sprite.new(1900, 0, Image.new(20, 1200, C_WHITE)),
  Sprite.new(20, 1180, Image.new(1880, 20, C_GREEN)),
  Sprite.new(1600, 280, Image.new(20, 900, C_WHITE))
] 

grounds = [
  Sprite.new(400, 800, Image.new(150, 20, C_GREEN)),
  Sprite.new(600, 200, Image.new(150, 20, C_GREEN)),
  Sprite.new(20, 200, Image.new(150, 20, C_GREEN))
]

ground_image = Sprite.new(1400, 200, Image.new(150, 20, C_GREEN))
ground_image2 = Sprite.new(750, 400, Image.new(150, 20, C_GREEN))
ground_move = [ground_image]
ground_move2 = [ground_image2]
ground_move2_puls = false
ground_move_puls = false


player = Sprite.new(0, 1000, Image.new(100, 100, C_WHITE))
player2 = Sprite.new(0, 1000, Image.new(100, 100, C_YELLOW))
item = Sprite.new(40, 150, Image.new(50, 50, C_WHITE))
item2 = Sprite.new(100, 150, Image.new(50, 50, C_YELLOW))
door = Sprite.new(1720, 880, Image.new(150, 300, C_RED))
door2 = Sprite.new(1720, 880, Image.new(150, 300, C_BLUE))
exitdoor = false

player_jump = 0
player2_jump = 0
player_exit = false
player2_exit = false
player_spead = 10

game_start = true
game_win = false
game2_win = false

Window.loop do
  if game_start
    Window.draw_font(600, 500, "えんたですたと",Font.default)
    if Input.key_push?(K_RETURN)
      game_start = false
    end
  elsif game_win
    Window.draw_font(100, 100, "白色が勝利！おめでとう！\n黄色はもうちょっと頑張って！",Font.default)
    if Input.key_push?(K_RETURN)
      game_win = false
      player.x = 20
      player.y = 1000
      item.draw
      door2.vanish
      door.draw
    end
  elsif game2_win
    Window.draw_font(100, 100, "黄色が勝利！おめでとう！\n白色はもうちょっと頑張って！",Font.default)
    if Input.key_push?(K_RETURN)
      game2_win = false
      player.x = 20
      player.y = 1000
      item.draw
      door2.vanish
      door.draw
    end
  else
    Sprite.draw(walls)
    Sprite.draw(grounds)
    Sprite.draw(ground_move)
    Sprite.draw(ground_move2)
    player.draw
    player2.draw
    item.draw
    item2.draw
    door.draw
    jump = false
    jump2 = false

    player.y += 20
    if player.y > 1080
      player.y = 1080
      jump = true
    end
    if player.x < 20
      player.x = 20
    end
    if player.x > 1800
      player.x = 1800
    end

    # プレイヤーと壁の上下左右の当たり判定
    walls.each do |wall|
      if player === wall
        player_jump = 0
        jump = true
        if Input.key_down?(K_RIGHT)
          if player.x + player.image.width + 10 > wall.x
            player.x = wall.x - player.image.width
          else
            player.x += 10
          end
        elsif Input.key_down?(K_LEFT)
          if player.x - 10 < wall.x + wall.image.width
            player.x = wall.x + wall.image.width
          else
            player.x -= 10
          end
        end
      end
    end
    grounds.each do |ground|
      if player === ground
        player_jump = 0
        player.y = ground.y - player.image.height
        jump = true
      end
    end
    ground_move.each do |move|
      if player === move
        player_jump = 0
        player.y = move.y - player.image.height
        player.x = move.x - player.image.height
        jump = true
      end
    end
    ground_move2.each do |move2|
      if player === move2
        player_jump = 0
        player.y = move2.y - player.image.height
        jump = true
      end
    end
    
    ground_image.y -= 10
    if ground_image.y <= 200
      ground_move_puls = true
    end
    if ground_move_puls
      ground_image.y += 20
    end
    if ground_image.y >= 600
      ground_move_puls = false
    end
    ground_image2.x -= 10
    if ground_image2.x <= 600
      ground_move2_puls = true
    end
    if ground_move2_puls
      ground_image2.x += 20
    end
    if ground_image2.x >= 1000
      ground_move2_puls = false
    end

    if jump
      if Input.key_push?(K_RETURN) && player_jump == 0
        player_jump = 10
        jump = false
      end
    end
    if Input.key_down?(K_RIGHT)
      player.x += 10
    end
    if Input.key_down?(K_LEFT)
      player.x -= 10
    end

    if player_jump > 0
      player.y -= 60
      player_jump -= 1
    end

    if player === item
      item.vanish
      door.vanish
      exitdoor = true
    end

    if exitdoor
      door2.draw
      player_exit = true
    end
    #プレイヤー２
    player2.y += 20
    if player2.y > 1080
      player2.y = 1080
      jump2 = true
    end
    if player2.x < 20
      player2.x = 20
    end
    if player2.x > 1800
      player2.x = 1800
    end

    # プレイヤーと壁の上下左右の当たり判定
    walls.each do |wall|
      if player2 === wall
        player2_jump = 0
        jump2 = true
        if Input.key_down?(K_D)
          if player2.x + player2.image.width + 10 > wall.x
            player2.x = wall.x - player2.image.width
          else
            player2.x += 10
          end
        elsif Input.key_down?(K_A)
          if player2.x - 10 < wall.x + wall.image.width
            player2.x = wall.x + wall.image.width
          else
            player2.x -= 10
          end
        end
      end
    end
    grounds.each do |ground|
      if player2 === ground
        player2_jump = 0
        player2.y = ground.y - player2.image.height
        jump2 = true
      end
    end
    ground_move.each do |move|
      if player2 === move
        player2_jump = 0
        player2.y = move.y - player2.image.height
        player2.x = move.x - player2.image.height
        jump2 = true
      end
    end
    ground_move2.each do |move2|
      if player2 === move2
        player2_jump = 0
        player2.y = move2.y - player2.image.height
        jump2 = true
      end
    end

    if jump2
      if Input.key_push?(K_SPACE) && player2_jump == 0
        player2_jump = 10
        jump2 = false
      end
    end
    if Input.key_down?(K_D)
      player2.x += 10
    end
    if Input.key_down?(K_A)
      player2.x -= 10
    end

    if player2_jump > 0
      player2.y -= 60
      player2_jump -= 1
    end

    if player2 === item2
      item2.vanish
      door.vanish
      exitdoor = true
      player2_exit = true
    end

    if exitdoor && player_exit
      door2.draw
      if player === door2
        game_win = true
      end
    end
    if exitdoor && player2_exit
      door2.draw
      if player2 === door2
        game2_win = true
      end
    end
  end
  # Window.draw_font(100, 100, "エグジットドア#{exitdoor}\nプレ２エグジット#{player2_exit}\n
  # ゲームウィン２#{game2_win}\n",Font.default)
  break if Input.key_push?(K_ESCAPE)
end