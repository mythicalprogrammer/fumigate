optionObj = {

  // max number of options to display within the dropdown button
  maxListLength: 2,

  // hide the select
  hideSelect: true,

  // keeps dropdown open for multiselects.
  multiselectStayOpen: true,

  // enables fuzzy search
  search: true,

  // respects dynamic changes to the select options.
  observeDomMutations: false,

  // max height of the dropdown
  maxHeight: '300px',

  // custom text
  textNoneSelected: "None selected",
  textMultipleSelected: "Multiple selected",
  textNoResults: "No results",
  htmlClear: "Clear search",

  // default CSS classes
  classDropdown: "dropdown",
  classBtnClear: "btn btn-outline-secondary",
  classBtnSearch: "btn btn-primary",
  classMenu: "dropdown-menu",
  classItem: "dropdown-item"

};

$('#company_select').selectDropdown(optionObj);
$('#accord_select').selectDropdown(optionObj);
$('#top_note_select').selectDropdown(optionObj);
$('#middle_note_select').selectDropdown(optionObj);
$('#base_note_select').selectDropdown(optionObj);

