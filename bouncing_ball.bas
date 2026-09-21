
Screen _NewImage(600, 600, 32)
Const WHITE = _RGB32(255, 255, 255)

dt = 0.1
acceleration_x = 0
acceleration_y = 9.8

velocity_x = 10
velocity_y = 0
position_x = 100
position_y = 100

For t = 0 To 600
    ' CLS
    velocity_x = velocity_x + acceleration_x * dt
    velocity_y = velocity_y + acceleration_y * dt
    position_x = position_x + velocity_x * dt
    position_y = position_y + velocity_y * dt
    If (position_x > 500) Then
        velocity_x = velocity_x * -1
        position_x = 499
    ElseIf (position_x < 100) Then
        velocity_x = velocity_x * -1
        position_x = 101
    End If

    'Y collision logic

    If (position_y > 500) Then
        velocity_y = velocity_y * -0.80
        position_y = 499
    ElseIf (position_y < 100) Then
        velocity_y = velocity_y * -1
        position_y = 101
    End If

    Circle (position_x, position_y), 10
    Line (100, 100)-(500, 500), WHITE, B
    _Delay 0.01



Next



