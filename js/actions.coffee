xRotationVal = 180
yRotationVal = 180
zRotationVal = 180

# Prepare Lighting using Photon (thanks Tom!)
light = new Photon.Light(-100,-300,0)
face  = new Photon.Face($('.face-1')[0], 1, .2, true)
face.render light, true

$ ->
  prepareRotationSlider($('.slide-control-rotateX'), xRotationVal)
  prepareRotationSlider($('.slide-control-rotateY'), yRotationVal)
  prepareRotationSlider($('.slide-control-rotateZ'), zRotationVal)

  # Bindings
  $('.action-reset').on 'click', ->
    xRotationVal = 180
    yRotationVal = 180
    zRotationVal = 180
    rotateView()

  $('.action-perspective').on 'click', ->
    xRotationVal = 236
    yRotationVal = 180
    zRotationVal = 140
    prepareRotationSlider($('.slide-control-rotateX'), xRotationVal)
    prepareRotationSlider($('.slide-control-rotateY'), yRotationVal)
    prepareRotationSlider($('.slide-control-rotateZ'), zRotationVal)
    rotateView()

  $('.cool').on 'animationend', ->
    console.log 'done with animation'


prepareRotationSlider = ($slideControl, rotationVal) ->
  preFilled = rotationVal / 360 * 100
  $slideControl.children('.slide-knob').css('left', preFilled + '%')
  $slideControl.children('.slide-filled').css('width', preFilled + 1 + '%')

  domElement = $slideControl.children('.draggable')[0]
  draggie = new Draggabilly(domElement,
    axis: "x",
    containment: $slideControl
  )
  draggie.on 'dragMove', onDragMove
  draggie.on 'dragEnd', onDragEnd


onDragMove = (instance, event, pointer) ->
  $triggerKnob = $(instance.element)
  sliderFill = calculateSliderFill(instance)
  switch $triggerKnob.parents('.slide-control').data('type')
    when 'rotateX'
      xRotationVal = Math.round(sliderFill * 360)
      updateSlider($triggerKnob, xRotationVal, sliderFill)
    when 'rotateY'
      yRotationVal = Math.round(sliderFill * 360)
      updateSlider($triggerKnob, yRotationVal, sliderFill)
    when 'rotateZ'
      zRotationVal = Math.round(sliderFill * 360)
      updateSlider($triggerKnob, zRotationVal, sliderFill)
  rotateView()
  return

onDragEnd = (instance, event, pointer) ->
  $(instance.element).children(".slide-value-modal").removeClass "visible"
  return

calculateSliderFill = (draggableInstance) ->
  sliderFill = draggableInstance.position.x / draggableInstance.containerSize.width
  sliderFill = (if sliderFill < 0 then 0 else sliderFill)
  return sliderFill


updateSlider = ($triggerKnob, newValue, fillAmount) ->
  $triggerKnob.siblings(".slide-filled").css("width", Math.round(fillAmount * 100) + "%")
  $triggerKnob.children(".slide-value-modal").html newValue
  $triggerKnob.children(".slide-value-modal").addClass "visible"


rotateView = () ->
  newTransformation = 'rotateX(' + xRotationVal + 'deg) rotateY(' + yRotationVal  + 'deg) rotateZ(' + zRotationVal + 'deg)'
  newBoxShadow = '-' + (xRotationVal / 2) + 'px ' + (yRotationVal /2) + 'px ' + (zRotationVal /2) + 'px rgba(0,0,0,.2)'
  $('.cool').removeClass('animated fadeInDown')
  $('.cool').css
    '-webkit-transform': newTransformation
    'box-shadow': newBoxShadow
  face.render light, true



