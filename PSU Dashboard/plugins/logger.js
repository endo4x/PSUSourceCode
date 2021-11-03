//
// A Clientside Implementation of the Stream Monkey Logger.
//

class Logger {
  constructor (serviceName, serviceColour) {
    this.serviceName = serviceName
    this.serviceColour = `color: ${serviceColour}`
  }

  getLevelColour (level) {
    switch (level.toLowerCase()) {
      case 'info': {
        return 'color: #5ba3eb'
      }
      case 'warn': {
        return 'color: #e1e35f'
      }
      case 'error': {
        return 'color: #e35f5f'
      }
    }
  }

  log (level, message) {
    console.log(`[%c${this.serviceName}%c][%c${level}%c] ${message}`, this.serviceColour, 'color: white', this.getLevelColour(level), 'color: white')
  }
}

export default Logger
