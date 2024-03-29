import
  nimgame2 / [
    assets,
    audio,
    entity,
    graphic,
    input,
    nimgame,
    textgraphic,
    scene,
    settings,
    types,
  ],
  ball,
  data,
  paddle


type
  MainScene = ref object of Scene
    leftPaddle, rightPaddle: Paddle
    ball: Ball
    scoreText: TextGraphic
    pause: Entity


proc initMainScene*(scene: MainScene) =
  Scene(scene).init()

  # left paddle
  scene.leftPaddle = newPaddle(ppLeft, pcPlayer1)
  scene.add scene.leftPaddle

  # right paddle
  scene.rightPaddle = newPaddle(ppRight, pcPlayer2)
  scene.add scene.rightPaddle

  # ball
  scene.ball = newBall()
  scene.add scene.ball

  # score
  scene.scoreText = newTextGraphic(bigFont)
  scene.scoreText.setText "0:0"
  let score = newEntity()
  score.graphic = scene.scoreText
  score.centrify()
  score.pos = (game.size.w / 2, score.graphic.dim.h.float)
  score.layer = 10 # text should be over other entities
  scene.add score

  # pause
  let pauseText = newTextGraphic(bigFont)
  pauseText.setText "PAUSE"
  scene.pause = newEntity()
  scene.pause.graphic = pauseText
  scene.pause.centrify()
  scene.pause.pos = game.size / 2
  scene.pause.visible = false
  scene.add scene.pause


proc free*(scene: MainScene) =
  scene.scoreText.free()


proc newMainScene*(): MainScene =
  new result, free
  initMainScene result


method event*(scene: MainScene, event: Event) =
  scene.eventScene(event)
  if event.kind == KeyDown:
    # Pause/Unpause
    if event.key.keysym.scancode == ScancodeP:
      gamePaused = not gamePaused
      scene.pause.visible = gamePaused


method show*(scene: MainScene) =
  echo "Switched to MainScene"
  scene.ball.reset()
  score1 = 0
  score2 = 0
  scene.scoreText.setText "0:0"
  discard sfxData["bell"].play()


method update*(scene: MainScene, elapsed: float) =
  scene.updateScene(elapsed)

  if ScancodeF10.pressed: colliderOutline = not colliderOutline
  if ScancodeF11.pressed: showInfo = not showInfo

  # check if the ball is out of the screen borders
  if (scene.ball.pos.x < 0) or (scene.ball.pos.x >= game.size.w.float) or
     (scene.ball.pos.y < 0) or (scene.ball.pos.y >= game.size.h.float):
    # increase score
    if scene.ball.pos.x < 0:
      inc score2
    else:
      inc score1
    # update score graphic
    scene.scoreText.setText $score1 & ":" & $score2
    # reset
    scene.ball.reset()
    discard sfxData["bell"].play()

