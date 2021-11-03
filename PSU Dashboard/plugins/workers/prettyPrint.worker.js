//
// PRETTY PRINT WORKER SCRIPT
//

/* global self postMessage */

import Logger from '../logger'

import { formatText } from 'lua-fmt'

// Create web worker logger
const logger = new Logger('PrettyPrint Worker', '#ed5c02')

logger.log('INFO', 'Initialised!')

self.addEventListener('message', (event) => {
  logger.log('INFO', 'Got a pretty print request!')

  // Start pretty printing stuff
  try {
    formatText(event.data)

    postMessage({ success: true, data: formatText(event.data) })
  } catch (err) {
    postMessage({ success: false, data: err.message })
  }
})
