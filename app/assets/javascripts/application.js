// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require underscore
//= require backbone
//= require_tree .

$(function(){

  var Task = Backbone.Model.extend({
    url: function() {
      var base = 'tasks';
      if (this.isNew()) return base;
      return base + (base.charAt(base.length - 1) == '/' ? '' : '/') + this.id;
    },

    defaults: function() {
      return {
        title: "",
        completed: false
      };
    },

    toggle: function() {
      this.save({completed: !this.get("completed")});
    }

  });

  var TaskList = Backbone.Collection.extend({
    model: Task,

    url: function() {
      var base = 'tasks';
      if (!this.get("id")) return base;
      return base + (base.charAt(base.length - 1) == '/' ? '' : '/') + this.get("id");
    },

    completed: function() {
      return this.where({completed: true});
    },

    remaining: function() {
      return this.without.apply(this, this.completed());
    }
  });

  var Tasks = new TaskList;

  var TaskView = Backbone.View.extend({
    tagName:  "li",

    template: _.template($('#item-template').html()),

    events: {
      "click .toggle"   : "toggleCompleted",
      "dblclick .view"  : "edit",
      "click a.destroy" : "clear",
      "keypress .edit"  : "updateOnEnter",
      "blur .edit"      : "close"
    },

    initialize: function() {
      this.listenTo(this.model, 'change', this.render);
      this.listenTo(this.model, 'destroy', this.remove);
    },

    render: function() {
      this.$el.html(this.template(this.model.toJSON()));
      this.$el.toggleClass('completed', this.model.get('completed'));
      this.input = this.$('.edit');
      return this;
    },

    toggleCompleted: function() {
      this.model.toggle();
    },

    edit: function() {
      this.$el.addClass("editing");
      this.input.focus();
    },

    close: function() {
      var value = this.input.val();
      if (!value) {
        this.clear();
      } else {
        this.model.save({title: value});
        this.$el.removeClass("editing");
      }
    },

    updateOnEnter: function(e) {
      if (e.keyCode == 13) this.close();
    },

    clear: function() {
      this.model.destroy();
    }

  });

  var AppView = Backbone.View.extend({
    el: $("#todoapp"),

    // Our template for the line of statistics at the bottom of the app.
    statsTemplate: _.template($('#stats-template').html()),

    // Delegated events for creating new items, and clearing completed ones.
    events: {
      "keypress #new-task":  "createOnEnter",
      "click #clear-completed": "clearCompleted",
      "click #toggle-all": "toggleAllComplete"
    },

    initialize: function() {
      this.input = this.$("#new-task");
      this.allCheckbox = this.$("#toggle-all")[0];

      this.listenTo(Tasks, 'add', this.addOne);
      this.listenTo(Tasks, 'reset', this.addAll);
      this.listenTo(Tasks, 'all', this.render);

      this.footer = this.$('footer');
      this.main = $('#main');

      Tasks.fetch();
    },

    render: function() {
      var completed = Tasks.completed().length;
      var remaining = Tasks.remaining().length;

      if (Tasks.length) {
        this.main.show();
        this.footer.show();
        this.footer.html(this.statsTemplate({completed: completed, remaining: remaining}));
      } else {
        this.main.hide();
        this.footer.hide();
      }

      this.allCheckbox.checked = !remaining;
    },

    addOne: function(task) {
      var view = new TaskView({model: task});
      this.$("#task-list").append(view.render().el);
    },

    addAll: function() {
      Tasks.each(this.addOne, this);
    },

    createOnEnter: function(e) {
      if (e.keyCode != 13) return;
      if (!this.input.val()) return;

      Tasks.create({title: this.input.val()});
      this.input.val('');
    },

    clearCompleted: function() {
      _.invoke(Tasks.completed(), 'destroy');
      return false;
    },

    toggleAllComplete: function () {
      var completed = this.allCheckbox.checked;
      Tasks.each(function (task) { task.save({'completed': completed}); });
    }

  });

  var App = new AppView;
});
