slotCycler = 0 % 4

function acceptInput(color, index){
  rowId = "row_" + (index + 1);
  slotId = "slot_" + slotCycler;
  moveId = "move_" + slotCycler;

  setSlot(color, rowId, slotId);
  setMove(color, moveId);

  slotCycler = (slotCycler + 1) % 4;
}

function setSlot(color, rowId, slotId){
  colorClass = color + " slot";
  row = document.getElementById(rowId);
  slot = row.querySelector("#"+slotId);
  slot.className = colorClass;
}

function setMove(color, moveId){
  input = document.getElementsByName(moveId)[0];
  input.value = color
}

