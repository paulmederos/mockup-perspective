xRotationVal = 0
yRotationVal = 0
zRotationVal = 0

$ ->
  prepareXRotationSlider()
  prepareYRotationSlider()
  prepareZRotationSlider()

  # Bindings
  $('.reset-all').on 'click', ->
    $('.cool').removeAttr('style')



onDragMoveRotateX = (instance, event, pointer) ->
  $triggerKnob = $(instance.element)

  # Do Math
  sliderFill = (instance.position.x / instance.containerSize.width)
  sliderFill = (if sliderFill < 0 then 0 else sliderFill)
  sliderPercent = Math.round(sliderFill * 100)
  xRotationVal = Math.round(sliderFill * 382)

  # Do painting + motion
  $triggerKnob.siblings(".slide-filled").css "width", sliderPercent + 1 + "%"
  $triggerKnob.children(".slide-value-modal").html xRotationVal
  $triggerKnob.children(".slide-value-modal").addClass "visible"
  rotateView()
  return

onDragMoveRotateY = (instance, event, pointer) ->
  $triggerKnob = $(instance.element)

  # Do Math
  sliderFill = (instance.position.x / instance.containerSize.width)
  sliderFill = (if sliderFill < 0 then 0 else sliderFill)
  sliderPercent = Math.round(sliderFill * 100)
  yRotationVal = Math.round(sliderFill * 382)

  # Do painting + motion
  $triggerKnob.siblings(".slide-filled").css "width", sliderPercent + 1 + "%"
  $triggerKnob.children(".slide-value-modal").html yRotationVal
  $triggerKnob.children(".slide-value-modal").addClass "visible"
  rotateView()
  return

onDragMoveRotateZ = (instance, event, pointer) ->
  $triggerKnob = $(instance.element)

  # Do Math
  sliderFill = (instance.position.x / instance.containerSize.width)
  sliderFill = (if sliderFill < 0 then 0 else sliderFill)
  sliderPercent = Math.round(sliderFill * 100)
  zRotationVal = Math.round(sliderFill * 382)

  # Do painting + motion
  $triggerKnob.siblings(".slide-filled").css "width", sliderPercent + 1 + "%"
  $triggerKnob.children(".slide-value-modal").html zRotationVal
  $triggerKnob.children(".slide-value-modal").addClass "visible"
  rotateView()
  return

onDragEnd = (instance, event, pointer) ->
  $(instance.element).children(".slide-value-modal").removeClass "visible"
  return

rotateView = () ->
  $(".cool").css "-webkit-transform", 'rotateX(' + xRotationVal + 'deg) rotateY(' + yRotationVal  + 'deg) rotateZ(' + zRotationVal + 'deg)'

prepareXRotationSlider = () ->
  $containerRotateX = $('.slide-control-rotateX')
  $containerRotateX.children('.slide-knob').css('left', '50%')
  $containerRotateX.children('.slide-filled').css('width', '51%')

  domElement = $containerRotateX.children('.draggable')[0]
  draggieRotateX = new Draggabilly(domElement,
    axis: "x",
    containment: $containerRotateX
  )
  draggieRotateX.on 'dragMove', onDragMoveRotateX
  draggieRotateX.on 'dragEnd', onDragEnd

prepareYRotationSlider = () ->
  $containerRotateY = $('.slide-control-rotateY')
  $containerRotateY.children('.slide-knob').css('left', '50%')
  $containerRotateY.children('.slide-filled').css('width', '51%')

  domElement = $containerRotateY.children('.draggable')[0]
  draggieRotateY = new Draggabilly(domElement,
    axis: "x",
    containment: $containerRotateY
  )
  draggieRotateY.on 'dragMove', onDragMoveRotateY
  draggieRotateY.on 'dragEnd', onDragEnd

prepareZRotationSlider = () ->
  $containerRotate = $('.slide-control-rotateZ')
  $containerRotate.children('.slide-knob').css('left', '50%')
  $containerRotate.children('.slide-filled').css('width', '51%')

  domElement = $containerRotate.children('.draggable')[0]
  draggieRotateZ = new Draggabilly(domElement,
    axis: "x",
    containment: $containerRotate
  )
  draggieRotateZ.on 'dragMove', onDragMoveRotateZ
  draggieRotateZ.on 'dragEnd', onDragEnd

