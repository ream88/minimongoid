class Minimongoid
  id: null
  attributes: {}

  constructor: (attributes = {}) ->
    @attributes = attributes
    @id = attributes._id
    @demongoize() if @isPersisted()

  isPersisted: -> @id?

  isValid: -> true

  save: ->
    return false unless @isValid()

    @mongoize()
    if @isPersisted()
      @constructor._collection.update @id, { $set: @attributes }
    else
      @id = @constructor._collection.insert @attributes

    this

  update: (@attributes) ->
    @save()

  destroy: ->
    if @isPersisted()
      @constructor._collection.remove @id
      @id = null

  mongoize: -> @_omitPrivateAttributes()

  demongoize: -> @_omitPrivateAttributes()

  _omitPrivateAttributes: ->
    attributes = {}
    for name, value of @attributes
      continue if name in ['_id', '_type']
      attributes[name] = value
    
    @attributes = attributes
    
    this

  @_collection: null

  # Rubists will love me, everyone else will burn me!
  #
  # Allows calls like User.new firstname: 'John'
  @new: (attributes) ->
    new @(attributes)

  @create: (attributes) ->
    @new(attributes).save()

  @where: (selector = {}, options = {}) ->
    @_collection.find(selector, options)

  @all: (selector = {}, options = {}) ->
    @_collection.find(selector, options)

  @toArray: (selector = {}, options = {}) ->
    for attributes in @where(selector, options).fetch()
      @new(attributes)

  @count: (selector = {}, options = {}) ->
    @where(selector, options).count()

  @destroyAll: (selector = {}) ->
    @_collection.remove(selector)
