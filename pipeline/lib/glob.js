const glob = require('glob')
const { Readable } = require('readable-stream')
const { promisify } = require('util')

class Glob extends Readable {
  constructor ({ pattern, ...options } = {}) {
    super({
      objectMode: true
    })

    this.pattern = pattern
    this.options = options
  }

  async _read () {
    const files = await promisify(glob)(this.pattern, this.options)

    files.forEach(file => {
      this.push(file)
    })

    this.push(null)
  }

  static create (options) {
    return new Glob(options)
  }
}

module.exports = Glob.create
