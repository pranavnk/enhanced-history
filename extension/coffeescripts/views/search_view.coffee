class BH.Views.SearchView extends Backbone.View
  className: 'search_view'
  templateId: 'search'

  #events:
    #'click .delete_all': 'clickedDeleteAll'

  initialize: ->
    @model.bind('change:title', @refreshTitle, @)
    #model.on('change:history', this.renderPageVisits, this);
    #this.model.on('change:text', this.updateTitle, this);
    #this.applySearchBehavior();

  render: ->
    @$el.append(@template(@model.toTemplate()))
    @

  refreshTitle: ->
    @$('.title').text(@model.get('title'))

  #renderPageVisits: function() {
    #this.collection = this.model.get('history');

    #this.$('.search').focus();
    #var contentElement = $(this.el).children('.content');
    #$(contentElement).html('');
    #this.$('.number_of_results').text(chrome.i18n.getMessage('number_of_search_results', [this.collection.length]));

    #if(this.collection.length === 0) {
        #$(contentElement).append(Mustache.render($('#noVisits').html(), i18n.search()));
      #this.$('.delete_all').attr('disabled', 'disabled');
    #} else {
      #var self = this;
      #this.collection.each(function(model) {
        #$(contentElement).append(new PageVisitView({model: model}).render().el);
      #});
      #this.$('.delete_all').attr('disabled', null);
    #}

    #Helpers.tabIndex($(contentElement).find('a'));
  #},

  #updateTitle: function() {
    #var title = this.model.buildSearchTitle(this.model.get('text'));
    #$('h2', this.$el).text(title);
    #Helpers.pageTitle(title);
    #$('.content', this.$el).html('');
  #},

  #clickedDeleteAll: function(ev) {
    #ev.preventDefault();
    #if($(ev.target).parent().attr('disabled') != 'disabled') {
      #this.promptView = CreatePrompt(chrome.i18n.getMessage('confirm_delete_all_search_results'));
      #this.promptView.open();
      #this.promptView.model.on('change', this.deleteAction, this);
    #}
  #},

  #deleteAction: function(prompt) {
    #if(prompt.get('action')) {
      #var self = this;
      #this.promptView.spin();
      #this.collection.destroyAll();
      #this.model.fetch({success: function(model) {
        #model.trigger('change:history'); // make sure
        #self.promptView.close();
      #}});
    #} else {
      #this.promptView.close();
    #}
  #}
#});