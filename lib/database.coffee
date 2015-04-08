fs = require 'fs'
mongoose = require 'mongoose'
config = require '../config/config'
path = require 'path'

mongoose.connect(config.database.url)

models_path = path.resolve __dirname, '../models'
fs.readdir models_path, (err, files) ->
	files.forEach (file) ->
		if ~file.indexOf '.coffee'
			require "#{models_path}/#{file}"

module.exports = mongoose
