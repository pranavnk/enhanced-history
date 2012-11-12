BH.Modules.workerSupport =
  worker: (name, options, callback) ->
    basePath = 'javascripts/workers'
    path = switch name
      when 'sanitizer'
        "#{basePath}/sanitizer.js"
      when 'domainGrouper'
        "#{basePath}/domain_grouper.js"
      when 'timeGrouper'
        "#{basePath}/time_grouper.js"
      when 'dayGrouper'
        "#{basePath}/day_grouper.js"

    worker = new Worker(path)

    worker.onmessage = (e) ->
      if (e.data.log)
        console.log(e.data.log)
      else
        callback(e.data)
    worker.postMessage(options)
