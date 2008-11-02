// ==========================================================================
// Contacts.MasterController
// ==========================================================================

require('core');

/** @class

  (Document Your View Here)

  @extends SC.Object
  @author    AuthorName
  @version 0.1
  @static
*/
Contacts.masterController = SC.CollectionController.create(
/** @scope Contacts.masterController */ {

  pickerIsVisible: false,

  // TODO: Add your own code here.
  allowsEmptySelection: false,
  allowsMultipleSelection: false,

  showPicker: function(sourceView, evt) {
    if (this.get('content')) {
      SC.page.get('photoPicker').popup(sourceView, evt);
    }
  },

  hidePicker: function() {
    SC.page.get('photoPicker').set('isVisible', false);
  },

  addContact: function(sourceView, evt) {
    var name = "the new guy";

    var contact = Contacts.Contact.newRecord({}, Contacts.server);

    this.set('selection', [contact]);

    if (this.get('content')) {
      SC.page.get('photoPicker').popup(sourceView, evt);
    }
  },

  deleteContact: function(sourceView, evt) {

    // FIXME: we shouldn't need to iterate since multiple selection is false

    // QUESTION: why do we need to removeObjects?

    var sel = (this.get('selection') || []).clone();
    var idx = sel.get('length');
    while (--idx >= 0) {
      var contact = sel.objectAt(idx);
      this.removeObjects(contact);
      contact.destroy();
    }

  },

  cancelEdit: function() {
    Contacts.detailController.discardChanges();
    SC.page.get('photoPicker').set('isVisible', false);

    var sel = (this.get('selection') || []).clone();
    var idx = sel.get('length');
    while (--idx >= 0) {
      var contact = sel.objectAt(idx);
      if (contact.newRecord) {
        this.removeObjects(contact);
        contact.destroy();
      }
    }
  },

  saveEdit: function() {
    Contacts.detailController.commitChanges();
    SC.page.get('photoPicker').set('isVisible', false);
    // FIXME: ?
  }
}) ;
