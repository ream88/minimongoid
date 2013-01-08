class Minimongoid
  id: undefined
  attributes: {}

  constructor: (attributes = {}) ->
    @attributes = attributes
    @id = attributes._id

  isPersisted: -> not _.isUndefined(@id)

  isValid: -> true

  save: ->
    return false unless @isValid()

    attributes = _.omit(@attributes, '_id', '_type')

    if @isPersisted()
      @_collection().update @id, { $set: attributes }
    else
      @id = @attributes._id = @_collection().insert attributes

    this

  update: (@attributes) ->
    @save()

  destroy: ->
    if @isPersisted()
      @_collection().remove @id
      @id = @attributes._id = undefined

  _collection: ->
    @constructor._collection

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
    for object in @where(selector, options).fetch()
      @new(object)

  @count: (selector = {}, options = {}) ->
    @where(selector, options).count()

  @destroyAll: (selector = {}) ->
    @_collection.remove(selector)

