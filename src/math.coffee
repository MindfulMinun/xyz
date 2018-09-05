xyz ?= {}

###*
 * The xyz.math namespace
 * @namespace
###
xyz.math = (n) ->
    if this.constructor isnt xyz.math
        return new xyz.math(...arguments)
    if typeof n isnt "number"
        throw new Error "Expected argument `n` to be of type number."
    @tokens = [+n]
    @

xyz.math::toString = -> @tokens.join ' '
xyz.math::valueOf  = -> xyz.math::eval.call(this)

xyz.math::add = (n) ->
    @tokens.push '+'
    @tokens.push +n
    @

xyz.math::sub = (n) ->
    @tokens.push '-'
    @tokens.push +n
    @

xyz.math::mult = (n) ->
    @tokens.push '*'
    @tokens.push +n
    @

xyz.math::div = (n) ->
    @tokens.push '/'
    @tokens.push +n
    @

xyz.math::eval = ->
    for token, i in @tokens
        if not (i % 2)
            if typeof token isnt "number"
                throw Error "Expected token at position #{i}
                    to be of type number."
        else
            if typeof token isnt "string"
                throw Error "Expected token at position #{i}
                    to be of type string."
    eval xyz.math::toString.call(this)
