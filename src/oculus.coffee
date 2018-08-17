copy      = require('copyjs')

class State
  constructor: (@name, @subscribers = {}, publishers = {}) ->
    # console.log { status: 'State constructor', name: @name, subscribers:@subscribers, publishers: publishers }
    if not @name?
      throw 'ill defined State without a name'
    for k,v of publishers 
      v.addSubscriber(@) if (@ != v)
    

  updateSelf: (obj,cb) ->
    # console.log { status: 'State.updateSelf, override for specific behavior', obj:obj }
    false

  publish: (obj,cb) ->
    # if state changes, update subscribers (todo avoid cycles, a publishes to b publishes to a...)
    # console.log { status: 'State publish', name: @name, subscribers:@subscribers  }
    if @updateSelf(obj)
      for k,v of @subscribers
        console.log { status: 'State.publish', name: @name, 'going to publish': @ != v, self: @ }
        v.publish(@) if (@ != v) # avoid recursive object loops... for now
    cb() if cb

  # addSubscriber to changes
  addSubscriber: (obj) ->
    # console.log { status: 'StateVal.addSubscriber', obj:obj }
    @subscribers = {} if not @subscribers?
    @subscribers[obj.name] = obj

  # two objects connect and subscribe to each others changes
  connect: (obj) ->
    # console.log { status: 'StateVal.connect', obj:obj }
    # circular reference, states subscribe to each other's changes
    @addSubscriber(obj)
    obj.addSubscriber(@)

# value based stats
class StateVal extends State
  constructor: (name, @val, subscribers, publishers) ->
    super(name, subscribers, publishers)
    # console.log { status: 'StateVal constructor', name: @name, val:@val, subscribers:@subscribers, publishers:@publishers }
    @
    
  updateSelf: (obj,cb) ->
    # console.log { status: 'StateVal.updateSelf', obj:obj }
    pre = copy @val
    if typeof obj.val is 'function'
      @val = obj.val()
    else
      @val = obj.val if obj.val?
    # console.log { status: 'StateVal.updateSelf', name: @name, 'going to return': pre != @val, pre: pre, post: @val } 
    pre != @val





module.exports =
  State: State,
  StateVal: StateVal
