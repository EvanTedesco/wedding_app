$(document).on('click', '.reservation-panels .panel div.clickable', function (e) {
  var $this = $(this),
    panelClosed = isClosed($this);
  
  closePanels();
  if(panelClosed){
    panelOpen($this);
  }
});

function panelClose($this) {
  $this.parents('.panel').find('.panel-body').slideUp();
  $this.addClass('panel-collapsed');
  $this.find('i').removeClass('glyphicon-minus').addClass('glyphicon-plus');
}

function panelOpen($this) {
  $this.parents('.panel').find('.panel-body').slideDown();
  $this.removeClass('panel-collapsed');
  $this.find('i').removeClass('glyphicon-plus').addClass('glyphicon-minus');
}

function isClosed ($this) {
  return $this.hasClass('panel-collapsed');
}

function closePanels() {
  $('.panel div.clickable').each(function () {
    panelClose($(this));
  });
}

$(closePanels);
