jquery-messagebox
=================

custom jquery message box plugin


A jquery plugin to create your own message box, by simply changing the configuration.

Many options available to customize the MessageBox: Below are the scripts that helpful in making messagebox work.


 Default Settings:
 
	settings = {
	  messageType: 'alert',
	  messageSubType: 'information',
	  title: 'Message',
	  messageText: '',
	}
	
	
 Options:
 
	1.  messageType
		a.  ‘alert’ (default)
		b.  ‘confirm’ 

	2.  messageSubType
		a.  ‘information’ (default)
		b.  ‘success’
		c.  ‘error’
		d.  ‘warning’

	3.  title
	
	4.  messageElementId
		ex: messageElementId : ‘#elementId’

	5.  messageText
	
	6.  height (numeric value)
	
	7.  width (numeric value)
	

 Events:
 
	1.  OkCallback
		Ex:
		OkCallback : function() {
			  alert(‘You clicked Ok’);
		}

	2.  onClose
		Ex:
		onClose: function() {
			alert(‘You closed the message box’);
		}

	3.  onCancel
		Ex:
		onCancel: function() {
			alert(‘You clicked cancel’);
		}
		

Download documentation for more details.
