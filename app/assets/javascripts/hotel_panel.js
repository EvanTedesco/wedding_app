$(document).on('click', '.reservation-panels .panel div.clickable', function () {
  var $this = $(this),
    panelClosed = isClosed($this);

  panelClose($this);
  if(panelClosed){
    panelOpen($this);
  }
});

function panelClose($this) {
  getBody($this).slideUp();
  $this.addClass('panel-collapsed');
  getIcon($this).removeClass('glyphicon-minus').addClass('glyphicon-plus');
}

function panelOpen($this) {
  getBody($this).slideDown();
  $this.removeClass('panel-collapsed');
  getIcon($this).removeClass('glyphicon-plus').addClass('glyphicon-minus');
}

function getBody($header) {
   return $header.parents('.panel').find('.panel-body')
}

function getIcon($header) {
  return $header.find('i');
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
