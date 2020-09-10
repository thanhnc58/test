import fs from 'fs'

const pathToData = 'data.json'
const pathToWriteTo = 'urls.json'
const domain = 'https://rsapi-staging.goong.io/Place/Autocomplete?api_key=7n6A7pzYqNV8UtX5ghXV2hEBnZppHobzfp3wVJVm'
const inputParam = 'input'
const limitPram = 'limit'

const curry = (func) => {

    const curried = (...args) => {
        if (args.length >= func.length) {
            return func.apply(this, args);
        } else {
            return (...args2) => {
                return curried.apply(this, args.concat(args2));
            }
        }
    };
    return curried
}
const createUrlFrom = (domain) => {
    return (...params) => {
        const url = new URL(domain)
        const appendParams = (acc, param) => {
            acc.searchParams.append(param.key, param.value)
            return acc
        }
        return `${params.reduce(appendParams, url).toString()}`
    }
}

const writeUrlsTo = (filePath, urls) => {
    const reducer = (acc, value) => {
        return `${acc}GET ${value}\n`
    }
    fs.writeFile(filePath, urls.reduce(reducer, ''), errorHandler)
}
const generator = function* (start, end) {
    for (let i = start; i <= end; i++) {
        yield i;
    }
}
const errorHandler = (err) => {
    if (err) {
        console.log(err)
    }
}
const substringsFrom = (str) => {
    return Array.from(str).map((_, index, arr) => arr.slice(0, index + 1).join(''))
}
const fromStringToUrls = (str, limit = 5) => substringsFrom(str).map(sub => {
    return urlCreator({key: inputParam, value: sub},
        {key: limitPram, value: limit})
})

const urlsWriter = curry(writeUrlsTo)(pathToWriteTo)
const urlCreator = createUrlFrom(domain)

const addressPatternsToUrls = (urlCreator, patterns) => patterns.flatMap(pattern => {
    if (pattern.hasOwnProperty('range')) {
        const begin = pattern['range']['begin']
        const end = pattern['range']['end']
        return [...generator(begin, end)].flatMap(i => fromStringToUrls(`${i} ${pattern['postfix']}`))
    } else {
        return [fromStringToUrls(pattern['postfix'])]
    }
})
const landmarksToUrls = (urlCreator, keywords) => keywords.flatMap(keyword => fromStringToUrls(keyword))
const genericsToUrls = (urlCreator, generics) => {
    return generics['keywords'].flatMap(generic => fromStringToUrls(generic, generics['limit']))
}

const addressHandler = curry(addressPatternsToUrls)(urlCreator)
const landmarksHandler = curry(landmarksToUrls)(urlCreator)
const genericHandler = curry(genericsToUrls)(urlCreator)

const handlers = new Map()

handlers['landmarks'] = landmarksHandler
handlers['addressPatterns'] = addressHandler
handlers['generics'] = genericHandler

const dataHandler = data => {
    const dataObject = JSON.parse(data)
    const urls = Object.keys(dataObject).flatMap(key => handlers[key](dataObject[key]))
    return urlsWriter(urls)
}

fs.readFile(pathToData, (err, data) => {
    if (err) errorHandler(err)
    else dataHandler(data)
})
