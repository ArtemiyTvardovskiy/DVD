
local sx, sy = guiGetScreenSize()

local picture = dxCreateTexture( "for_texture.png" )

local coeficient_x_to_y = 2331 / 1095

local delta_x_for_frame = sx * 0.01
local delta_y_for_frame = sy * 0.01
 
local default_size_picture_x = sx / 7
local default_size_picture_y = sy / 7

local function generate_needed_sizes()
    local size_x_1, size_y_1 = default_size_picture_x, default_size_picture_x * (1 / coeficient_x_to_y)
    local size_y_2, size_x_2 = default_size_picture_y, default_size_picture_y * (coeficient_x_to_y)

    if size_y_1 > sy / 4 then return size_x_2, size_y_2 end

    return size_x_1, size_y_1
end

local real_size_x, real_size_y = generate_needed_sizes()

local parameters_figures = {
    { coeficient_x = 1, coeficient_y = 1, max_x = sx / 2 - real_size_x, max_y = sy - real_size_y, min_x = 0 },
    { coeficient_x = 1, coeficient_y = 1, max_x = sx / 2 - real_size_x + sx / 2, max_y = sy - real_size_y, min_x = sx / 2 }
}

for i = 1, 2 do
    parameters_figures[i].x = math.random( sx / 2 - real_size_x ) + parameters_figures[i].min_x
    parameters_figures[i].y = math.random( parameters_figures[i].max_y )
    parameters_figures[i].color = tocolor( math.random( 255 ), math.random( 255 ), math.random( 255 ) )
end

local function set_parameters_for_texture( i )
    local delta_x = delta_x_for_frame * parameters_figures[i].coeficient_x
    local delta_y = delta_y_for_frame * parameters_figures[i].coeficient_y
    local new_x = parameters_figures[i].x + delta_x
    local new_y = parameters_figures[i].y + delta_y

    if new_x > parameters_figures[i].max_x or new_x < parameters_figures[i].min_x then
        parameters_figures[i].x = new_x - 2 * delta_x
        parameters_figures[i].coeficient_x = - parameters_figures[i].coeficient_x
        parameters_figures[i].color = tocolor( math.random( 255 ), math.random( 255 ), math.random( 255 ) )
    else
        parameters_figures[i].x = new_x
    end

    if new_y > parameters_figures[i].max_y or new_y < 0 then
        parameters_figures[i].y = new_y - 2 * delta_y
        parameters_figures[i].coeficient_y = - parameters_figures[i].coeficient_y
        parameters_figures[i].color = tocolor( math.random( 255 ), math.random( 255 ), math.random( 255 ) )
    else
        parameters_figures[i].y = new_y
    end
end

addEventHandler( "onClientRender", root, function()
    --dxDrawLine(sx/2, 0, sx/2, sy)
    set_parameters_for_texture( 1 )
    set_parameters_for_texture( 2 )
    dxDrawImage( parameters_figures[1].x, parameters_figures[1].y, real_size_x, real_size_y, picture, 0, 0, 0, parameters_figures[1].color )
    dxDrawImage( parameters_figures[2].x, parameters_figures[2].y, real_size_x, real_size_y, picture, 0, 0, 0, parameters_figures[2].color )
end )