local Activateforce = Class(function(self, inst)self.inst = instself.onWorking = nilend)function Activateforce:CanInteract()	if self.caninteractfn then		return self.caninteractfn(self.inst)	else		return true	endendfunction Activateforce:CollectInventoryActions(doer, actions)	if self:CanInteract() then		    table.insert(actions, ACTIONS.ACTIVATEFORCE)	   		endendfunction Activateforce:Working(inst, doer)	if self.onWorking then		self.onWorking(self.inst, doer)	endendreturn Activateforce