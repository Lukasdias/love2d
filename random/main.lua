SPEED = 500
START_X = 400
START_Y = 300
RADIUS = 50

function love.load()
    ball = {
        x = 400, 
        y = 300,
        radius = RADIUS, 
        speed = SPEED 
    }
end

function love.update(dt)
    local mouseX, mouseY = love.mouse.getPosition()

    local directionX = mouseX - ball.x
    local directionY = mouseY - ball.y

    local length = math.sqrt(directionX * directionX + directionY * directionY)
    
    if length > 0 then
        directionX = directionX / length
        directionY = directionY / length
    end

    if(length < 50) then
        ball.speed = 0
    else
        ball.speed = SPEED
    end

    ball.x = ball.x + directionX * ball.speed * dt
    ball.y = ball.y + directionY * ball.speed * dt
end

function love.draw()
    love.graphics.setColor(1, 1, 0)
    love.graphics.circle("fill", ball.x, ball.y, ball.radius)
end