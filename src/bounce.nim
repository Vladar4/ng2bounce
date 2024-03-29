import
  nimgame2/nimgame,
  data,
  title,
  main


game = newGame()
if game.init(GameWidth, GameHeight, title = GameTitle, integerScale = true):

  # Init
  game.setResizable(true) # Window could be resized
  game.minSize = (GameWidth, GameHeight) # Minimal window size
  game.windowSize = (GameWidth * 2, GameHeight * 2) # Double scaling (1280x720)
  game.centrify() # Place window at the center of the screen

  loadData() # Call it before any scene initialization

  # Create scenes
  titleScene = newTitleScene()
  mainScene = newMainScene()

  # Run
  game.scene = titleScene # Initial scene
  run game  # Let's go!

