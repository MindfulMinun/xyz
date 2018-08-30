###*
 * The xyz namespace
 * @namespace
###
xyz = new Object

###*
 * Gets some JSON from some url.
 * @author MindfulMinun
 * @param {String} url - The URL to get the data from.
 * @returns {Promise<Response>}
 * @example
 * xyz.getJSON('https://jsonplaceholder.typicode.com/todos/1')
 *     .then(console.log);
 * // {
 * //   "userId": 1,
 * //   "id": 1,
 * //   "title": "delectus aut autem",
 * //   "completed": false
 * // }
 * @since Aug 30, 2018
 * @version 0.1.0
###
xyz.getJSON = (url) ->
    new Promise (resolve, reject) ->
        r = new XMLHttpRequest
        r.open 'GET', url, yes
        r.onload = ->
            if 200 <= @status < 400
                # Success!
                resolve JSON.parse @response
            else
                # Server reached, returned error
                reject @response
        r.send()

###*
 * Posts some JSON data to some url.
 * @author MindfulMinun
 * @param {String} url - The URL to post the data to.
 * @param {Object} data - The data to post.
 * @returns {undefined}
 * @since Aug 30, 2018
 * @example
 * xyz.postJSON('https://jsonplaceholder.typicode.com/posts', {
 *   "title": "My example JSON"
 * });
 * @version 0.1.0
###
xyz.postJSON = (url, data) ->
    r = new XMLHttpRequest
    r.open 'POST', url, yes
    r.setRequestHeader 'Content-Type', 'application/json; charset=UTF-8'
    r.send data
    return

###*
 * Gets some data from some url.
 * @author MindfulMinun
 * @param {String} url - The URL to get the data from.
 * @returns {Promise<Response>}
 * @since Aug 30, 2018
 * @version 0.1.0
###
xyz.get = (url) ->
    new Promise (resolve, reject) ->
        r = new XMLHttpRequest
        r.open 'GET', url, yes
        r.onload = ->
            if 200 <= @status < 400
                # Success!
                resolve @response
            else
                # Server reached, returned error
                reject @response
        r.send()

###*
 * Posts some data to some url.
 * @author MindfulMinun
 * @param {String} url - The URL to post the data to.
 * @param {String} data - The data to post.
 * @returns {undefined}
 * @since Aug 30, 2018
 * @version 0.1.0
###
xyz.post = (url, data) ->
    r = new XMLHttpRequest
    r.open 'POST', url, yes
    r.setRequestHeader 'Content-Type', 'application/x-www-form-urlencoded;
        charset=UTF-8'
    r.send data
    return

###*
 * Calls a function for each element of the array, then returns that array.
 * @author MindfulMinun
 * @param {Array} arr - The array to loop over
 * @callback {Function} fn - The function to call on every array
 * @param {*} el - The element
 * @param {Number} i - The element’s index
 * @param {Array} arr - The array the element is a member of
 * @returns {Array} The array that was looped over
 * @since Aug 22, 2018
 * @example
 * xyz.tap([1, 2, 3, 4, 5], function (el, i, arr) {
 *     console.log(el);
 * });
 * @version 0.1.0
###
xyz.tap = (arr, fn) ->
    for el, i in arr
        fn(el, i, arr)
    arr


###*
 * Chooses a random element from an array.
 * @author MindfulMinun
 * @param {Array} arr - The array to choose from
 * @returns {*} An array element
 * @private
 * @example
 * xyz._chooseArray([1, 2, 3, 4, 5]) // -> A random element
 * @since Aug 28, 2018
 * @version 0.1.0
###
xyz._chooseArray = (arr) ->
    arr[Math.floor Math.random() * arr.length]

###*
 * Retrieves an element from an array given its index.
 * @author MindfulMinun
 * @param {Array} arr - The array retrieve from
 * @param {Number} i - The index of the element to retrieve.
    If negative, the nth element from the end is returned.
 * @returns {*} The nth element from the array.
 * @example
 * var arr = [0, 1, 2, 3, 4, 5]
 * xyz.nth(arr, 0)  // -> 0
 * xyz.nth(arr, 4)  // -> 4
 * xyz.nth(arr, -0) // -> 5
 * xyz.nth(arr, -4) // -> 1
 * @since Aug 28, 2018
 * @version 0.1.0
###
xyz.nth = (arr, i) ->
    _isPositiveZero = (zero) -> 1 / zero is Infinity
    pos = i
    neg = (arr.length - 1) + i
    if i isnt 0
        arr[if Math.sign(i) is 1 then pos else neg]
    else
        arr[if _isPositiveZero(i) then pos else neg]

###*
 * Parses a string of HTML.
 * @author MindfulMinun
 * @param {String} html - The HTML to parse
 * @returns {HTMLElement[]} - An array of HTML elements.
 * @example
 * xyz.parseHTML(`
 *     <h1>My header</h1>
 *     <p>My paragraph</p>
 * `) // -> [h1, p]
 * @since Aug 23, 2018
 * @version 0.1.0
###
xyz.parseHTML = (html) ->
    tmp = document.implementation.createHTMLDocument()
    tmp.body.innerHTML = html
    Array.from tmp.body.children

###*
 * Escapes an unsafe string for use in HTML / XML
 * @author MindfulMinun
 * @param {String} unsafe - The unsafe string to escape
 * @returns {String} The escaped string
 * @example
 * xyz.escapeHTML('<my unsafe="string">')
 * // -> '&lt;my unsafe=&quot;string&quot;&gt;'
 * @since Aug 24, 2018
 * @version 0.1.0
###
xyz.escapeHTML = (unsafe) ->
    _escapeMap = {
        '&': '&amp;'
        '<': '&lt;'
        '>': '&gt;'
        '"': '&quot;'
        "'": '&#39;'
    }
    unsafe.replace(/[&<>"']/g, (m) -> _escapeMap[m])

###*
 * Returns a random number between `min` and `max`, optionally floating.
 * @author MindfulMinun
 * @param {Number} [min] - The lower bound to generate numbers from.
    Defaults to 0.
 * @param {Number} [max] - The upper bound to generate numbers from.
 * @param {Boolean} [float] - Whether to return a floating-point number or
    an integer. Defaults to false.
 * @returns {Number} The randomly generated number.
 * @example
 * xyz.random()           // -> random float between 0 and 1
 * xyz.random(8)          // -> random int between 0 and 8
 * xyz.random(8, true)    // -> random float between 0 and 8
 * xyz.random(4, 8)       // -> random int between 4 and 8
 * xyz.random(4, 8, true) // -> random float between 4 and 8
 * @since Aug 23, 2018
 * @version 0.1.0
###
xyz.random = (min, max, float) ->
    a = arguments
    switch a.length
        when 0 then return Math.random() # xd shhh
        when 1
            if typeof a[0] is "number"
                [min, max, float] = [0, a[0], no]
            else
                throw Error "Expected argument `max` to be a finite number."
        when 2
            switch typeof a[1]
                when "number"  then [min, max, float] = [a[0], a[1], no]
                when "boolean" then [min, max, float] = [0, a[0], a[1]]
                else throw Error "Expected last argument to be
                    either a boolean or a number."
        when 3 then [min, max, float] = [min, max, float]
        else throw Error "Expected at most 3 arguments, instead saw #{a.length}"


    #! Type checking
    if not Number.isFinite(min)
        throw Error "Expected argument `min` to be a finite number."
    if not Number.isFinite(max)
        throw Error "Expected argument `max` to be a finite number."
    if typeof float isnt "boolean"
        throw Error "Expected argument `float` to be a boolean."
    if min >= max
        throw Error "Expected argument `min` (#{min}) to be less
            than `max` (#{max})"

    # [min, max, float]

    if float
        # Return floating-point number
        Math.random() * (max - min) + min
    else
        # Return integer
        [min, max] = [Math.floor(min), Math.ceil(max)]
        Math.floor(Math.random() * (max - min)) + min

###*
 * Determine if a and b are equivalent.
 * @author MindfulMinun
 * @param {*} a - The object to compare to `b`
 * @param {*} b - The object to compare to `a`
 * @returns {Boolean} Whether `a` and `b` are the same value
 * @example
 * xyz.is(NaN, 0 / 0) // -> true
 * xyz.is(0, 0)       // -> true
 * xyz.is(-0, 0)      // -> false
 * @since Aug 28, 2018
 * @version 0.1.0
###
xyz.is = (a, b) ->
    # Modeled after Object.is Same-value algorithm
    if a is b
        (a isnt 0) or ((1 / a) is (1 / b))
    else # ¿NaN is NaN?
        (a isnt a) and (b isnt b)

###*
 * Determine the type of an object.
 * @author MindfulMinun
 * @param {*} obj - The object with an unknown type.
 * @returns {String} The object's type.
 * @example
 * var set = new Set
 * ,   map = new Map
 * ,   arr = new Array;
 * xyz.type(set) // -> "set"
 * xyz.type(map) // -> "map"
 * xyz.type(arr) // -> "array"
 * @since Aug 28, 2018
 * @version 0.1.0
###
xyz.type = (obj) ->
    Object::toString.call(obj).replace(/^\[object (.+)\]$/, '$1').toLowerCase()


### *** Exports *** ###
if this is window?
    window.xyz = xyz
else
    module.exports = xyz
