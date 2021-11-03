//
// Worker Manager, A script to control and fire web workers in PSU Dash
//

import PrettyWorker from './prettyPrint.worker.js'
import Logger from '../logger'

// Create web worker logger
const logger = new Logger('Worker Manager', '#4287f5')

logger.log('INFO', 'Initialised!')

export default (context, inject) => {
  inject('worker', {
    createWorker (workerName) {
      switch (workerName) {
        case 'PrettyWorker': {
          logger.log('INFO', 'Registering new web worker: "PrettyWorker"')
          return new PrettyWorker()
        }
      }
    }
  })
}
