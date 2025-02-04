local SPEED = 200
local GRAVITY = 500
local ball = { x = 400, y = 300, radius = 30, speed = SPEED }
local particles = {}
local walls = {}

function love.load()
    love.window.setMode(800, 600)
    love.window.setTitle("Ball and Particles")

    -- Define walls
    walls = {
        { x = 0, y = 0, width = 800, height = 10 }, -- Top wall
        { x = 0, y = 590, width = 800, height = 10 }, -- Bottom wall
        { x = 0, y = 0, width = 10, height = 600 }, -- Left wall
        { x = 790, y = 0, width = 10, height = 600 } -- Right wall
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

    if length < 50 then
        ball.speed = 0
    else
        ball.speed = SPEED
    end

    ball.x = ball.x + directionX * ball.speed * dt
    ball.y = ball.y + directionY * ball.speed * dt

    if love.keyboard.isDown("space") then
        table.insert(particles, { x = ball.x, y = ball.y, life = 1, vx = directionX * SPEED, vy = directionY * SPEED })
    end

    for i = #particles, 1, -1 do
        local particle = particles[i]
        particle.life = particle.life - dt
        particle.vy = particle.vy + GRAVITY * dt
        particle.x = particle.x + particle.vx * dt
        particle.y = particle.y + particle.vy * dt

        if particle.life <= 0 or particle.x < 0 or particle.x > 800 or particle.y < 0 or particle.y > 600 then
            table.remove(particles, i)
        end
    end
end

function love.draw()
    -- Draw background
    love.graphics.setColor(0.1, 0.1, 0.1)
    love.graphics.rectangle("fill", 0, 0, 800, 600)

    -- Draw walls
    love.graphics.setColor(0.5, 0.5, 0.5)
    for _, wall in ipairs(walls) do
        love.graphics.rectangle("fill", wall.x, wall.y, wall.width, wall.height)
    end

    -- Draw ball
    love.graphics.setColor(1, 1, 0)
    love.graphics.circle("fill", ball.x, ball.y, ball.radius)

    -- Draw particles
    love.graphics.setColor(1, 1, 1)
    for _, particle in ipairs(particles) do
        love.graphics.circle("fill", particle.x, particle.y, 2)
    end
end