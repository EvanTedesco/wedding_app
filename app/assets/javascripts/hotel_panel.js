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
  console.log('Closed');
}

function panelOpen($this) {
  $this.parents('.panel').find('.panel-body').slideDown();
  $this.removeClass('panel-collapsed');
  $this.find('i').removeClass('glyphicon-plus').addClass('glyphicon-minus');
  console.log('Opened');
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

/*  one open at a time
 * icon shows minus or plus depending on container being open or closed
 * transition = slideUp/slideDown*/