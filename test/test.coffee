oculus    = require('../oculus')
State     = oculus.State
StateVal  = oculus.StateVal
$         = require('jquery')
log       = console.log


# PageElement is a special case of State
# where name corresponds to the #divID
class PageElement extends State
  constructor: (name, subscribers, publishers) ->
    super(name, subscribers, publishers)
    console.log { status: 'PageElement constructor', name: @name, subscribers: @subscribers, publishers: publishers }

  updateSelf: (obj,cb) ->
    console.log { status: 'PageElement.updateSelf(obj)', obj: obj }
    true

  publish: (obj,cb) ->
    if @updateSelf(obj)
      console.log { status: 'PageElement.published(obj).and.updatedSelf', obj: obj }
  

# new cold StateVal with id cold, val='ooze', and no subscribers
console.log 'about to create cold StateVal'
cold = new StateVal('cold', 'ooze', {}, {})

# elem subscribes to changes in cold object (a publisher), but has no subscribers itself
elem = new PageElement('#funky', {}, { cold: cold })

cold.publish({ val: 'medina' })

# { status: 'PageElement.published(obj).and.updatedSelf',
#   obj: 
#    StateVal {
#      name: 'cold',
#      subscribers: { '#funky': [PageElement] },
#      val: 'medina' } }

