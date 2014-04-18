noflo = require 'noflo'

class Stroke extends noflo.Component
  description: 'Strokes the received paths, rectangles, circles, and arcs as lines'
  icon: 'square-o'
  constructor: ->
    @stroke =
      type: 'stroke'
      strokables: []
      strokeStyle: null
      lineWidth: null
      closePath: false
    
    @inPorts =
      strokables: new noflo.ArrayPort 'array'
      strokestyle: new noflo.Port 'string'
      linewidth: new noflo.Port 'number'
      closepath: new noflo.Port 'boolean'
    @outPorts =
      stroke: new noflo.Port 'object'

    @inPorts.strokables.on 'data', (data, i) =>
      @stroke.strokables[i] = data
      @compute()

    @inPorts.strokestyle.on 'data', (data) =>
      @stroke.strokeStyle = data
      @compute()

    @inPorts.linewidth.on 'data', (data) =>
      @stroke.lineWidth = data
      @compute()

    @inPorts.closepath.on 'data', (data) =>
      @stroke.closePath = data
      @compute()

    # TODO listen for detach / reindex

  compute: ->
    if @outPorts.stroke.isAttached() and @stroke.strokables.length > 0
      @outPorts.stroke.send @stroke

    # TODO listen for detach / reindex

exports.getComponent = -> new Stroke
