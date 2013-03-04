Array.prototype.all = (test, context) ->
  satisfied = true
  for element in this
    satisfied = false unless test.call(context, element)

  satisfied

Object.prototype.extend = (obj) ->
  for own key, val of obj
    this[key] = val

  this

class Minimongoid
  id: undefined
  attributes: {}

  constructor: (attributes = {}) ->
    if attributes._id
      @attributes = @demongoize(attributes)
      @id = attributes._id
    else
      @attributes = attributes

  isPersisted: -> @id?

  isValid: -> true

  save: ->
    return false unless @isValid()
    
    attributes = @mongoize(@attributes)
    attributes['_type'] = @constructor._type if @constructor._type?
    
    if @isPersisted()
      @constructor._collection.update @id, { $set: attributes }
    else
      @id = @constructor._collection.insert attributes
    
    this.extend attributes

  update: (@attributes) ->
    @save()

  destroy: ->
    if @isPersisted()
      @constructor._collection.remove @id
      @id = null

  mongoize: (attributes) ->
    taken = {}
    for name, value of attributes
      continue if name.match(/^_/)
      taken[name] = value
    taken

  demongoize: (attributes) ->
    taken = {}
    for name, value of attributes
      continue if name.match(/^_/)
      taken[name] = value
    taken

  @_collection: undefined
  @_type: undefined

  # Rubists will love me, everyone else will burn me!
  #
  # Allows calls like User.new firstname: 'John'
  @new: (attributes) ->
    model = new @(attributes)
    model.extend(attributes)

  @create: (attributes) ->
    model = @new(attributes).save()

  @where: (selector = {}, options = {}) ->
    @_collection.find(selector, options).map (record) =>
      @new record

  @all: (selector = {}, options = {}) ->
    @where(selector, options)

  @find: (selector = {}, options = {}) ->
    document = @_collection.findOne(selector, options)
    if document
      new @(document)

  @count: (selector = {}, options = {}) ->
    @where(selector, options).length

  @destroyAll: (selector = {}) ->
    @_collection.remove(selector)
