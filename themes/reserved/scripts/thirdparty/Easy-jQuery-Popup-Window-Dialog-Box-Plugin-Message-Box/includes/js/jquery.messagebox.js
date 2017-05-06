/*
	Custom Message box plugin for jQuery (https://github.com/mpsiva89/jquery-messagebox)
	Copyright (c) 2013 SivaKumar and Jeyadevan
	Licensed under the MIT license (http://opensource.org/licenses/mit-license.html)
	Version: 1.0.3
*/

(function($, window, document, undefined) {
 
 	var html = '<div class="msgboxOverlay"><div class="alert-box msgwrapper"><div class="information"><div class="msgcontainer"><div class="msgheader"><a href="javascript:void(0);" class="msgclose">Close</a><span>Message Box Title</span></div><div class="msg">Text</div><div class="msgfooter"></div></div></div></div></div>';
 	
 	var currentMessageBox;
 	
 	var buttonOk = '<button type="button" class="buttonOK">Ok</button>';
 	var buttonCancel = '<button type="button" class="buttonCancel">Cancel</button>';
 	
 	var settings ;
 	
 	
 	var pluginName = 'messagebox';
 	
 	function MessageBoxPlugin(element, options) {
 		
 		this.settings = settings;
 		
 		this.element = element;
 		
 		if (options) {
 		   this.options = options;
        }
        
        var current = this;
        
        $(this.element).click(function() {
 			current.createMessageBox();
 			$('body').prepend(currentMessageBox);
 			current.intialize();
 		});
        
 	} 
 	
 	MessageBoxPlugin.prototype.createMessageBox = function() {
 		$.extend(this.settings, this.options);
 		var temp = $(html);
 		if(this.settings.messageElementId) {
 			temp.find('.msg').html($(this.settings.messageElementId).html());
 		} else {
			temp.find('.msg').html(this.settings.messageText); 			
 		}
 		
 		if(this.settings.height)
 		  temp.find('.msg').height(this.settings.height);
 		if(this.settings.width)
 		  temp.find('.msgcontainer').width(this.settings.width);
 		temp.find('.msgheader span').html(this.settings.title);
 		temp.find('.information').removeClass('information').addClass(this.settings.messageSubType);
 		var buttons = buttonOk;
 		if(this.settings.messageType === 'confirm') {
 			buttons = buttons + buttonCancel;
 		}
 		
 		temp.find('.msgfooter').html(buttons);
 		
 		currentMessageBox = $('<div>').append(temp.clone()).html();
 	}
 	
 	MessageBoxPlugin.prototype.intialize = function() {
 		var current = this;
 		$.extend(current.settings, current.options);
 		
 		$('.msgboxOverlay .msgclose').off("click");
 		$('.msgboxOverlay .msgclose').on("click", function() {
 			$('.msgboxOverlay').remove();
 			if(current.settings.onClose) {
 				current.settings.onClose();
 			}
 		});
 		

		$('.msgboxOverlay .buttonOK').off('click');
		$('.msgboxOverlay .buttonOK').on('click', function() {
			$('.msgboxOverlay').remove();
			if(current.settings.OkCallback) {
				current.settings.OkCallback();
			}
		});
 		
 		if(this.settings.messageType === 'confirm') {
 			$('.msgboxOverlay .buttonCancel').off('click');
			$('.msgboxOverlay .buttonCancel').on('click', function() {
				$('.msgboxOverlay').remove();
				if(current.settings.onCancel) {
					current.settings.onCancel();
				}
			});
 		}
 			
 	}
 	
 
    $.fn.messagebox = function(options) {
 		
		settings = {
			messageType: 'alert',
			messageSubType: 'information',
			title: 'Message',
			messageElementId: null,
			messageText: '',
			height: null,
			width: null,
			OkCallback : null,
			onClose: null,
			onCancel : null
		};
		
 		return this.each(function () {
 			if (!$.data(this, 'plugin_' + pluginName)) {
                $.data(this, 'plugin_' + pluginName, 
                new MessageBoxPlugin( this, options ));
            }
        });   
 		
    };
 
}(jQuery, window, document));