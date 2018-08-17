![oculus](https://github.com/victusfate/oculus/raw/master/oculus.jpg)
oculus
===
oculus is a tool to simplify object transition, and communication of state (pub/sub pattern) through the use of named objects (unique id)

	cold = new StateVal('cold','ooze',{})

	// funky subscribes to changes in cold object
	funky = new StateVal('funky', { 'cold': cold} )

	// update and publish cold state to its listeners
	cold.publish({ val: 'medina' })
  ```
  { status: 'PageElement.published(obj).and.updatedSelf',
    obj: 
     StateVal {
       name: 'cold',
       subscribers: { '#funky': [PageElement] },
       val: 'medina' } }
  ```     
license: BSD

