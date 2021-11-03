//
// PLEASE NOTE! THIS IS A TEMPORARY PROJECT MANAGER WHILE I WAIT ON THE SERVER IMPLEMENTATION!!!!
//

import localforage from 'localforage'
import { nanoid } from 'nanoid'

import Logger from '../plugins/logger'

const logger = new Logger('PROJECT API', '#6e3ac7')

const API_URL = 'https://next.psu.dev/api/v2/scripts/'

localforage.config({
  name: 'PSUDash',
  version: 1.0,
  description: 'PSU Dashboard localforage'
})

async function deleteScript (ID, token) {
  return await fetch(API_URL + 'deleteScript', { // eslint-disable-line
    method: 'POST',
    body: JSON.stringify({ token: token, scriptID: ID }),
    headers: {
      'Content-Type': 'application/json'
    }
  })
    .then(response => response.json())
    .then(data => {
      return data
    })
    .catch(error => {
      window.createNotification('ERROR', `ERROR: ${error}`, 15)
      console.error(error)
    })
}

// async function obfuscateScript (scriptData) {
//   // Notify the notification API that a new obfuscation has token place.
//
// }

async function getScript (ID, token) {
  let data = await fetch(API_URL + 'getScript', { // eslint-disable-line
    method: 'POST',
    body: JSON.stringify({
      token: token,
      scriptID: ID
    }),
    headers: {
      'Content-Type': 'application/json'
    }
  })
    .then(response => response)
    .catch(error => {
      window.createNotification('ERROR', `ERROR: ${error}`, 15)
      console.error(error)
    })

  return { success: true, data: await data.text() }
}

async function loadProjects (token) {
  return await fetch(API_URL + 'private/getAllScripts', { // eslint-disable-line
    method: 'POST',
    body: JSON.stringify({ token: token }),
    headers: {
      'Content-Type': 'application/json'
    }
  })
    .then(response => response.json())
    .then(data => {
      return data.data
    })
    .catch(error => {
      window.createNotification('ERROR', `ERROR: ${error}`, 15)
      console.error(error)
    })
}

async function createProject (projectData) {
  projectData.ID = nanoid() // Add a ID to it.
  localforage.getItem('PSU_Projects', function (err, value) {
    if (err) {
      logger.log('error', `An error occoured when creating project: ${projectData.title}! ${err}`)
      return
    }
    if (!value) {
      localforage.setItem('PSU_Projects', [projectData], () => {
        logger.log('info', `Successfully created project: ${projectData.title} with UUID: ${projectData.ID}`)
      })
    } else {
      localforage.setItem('PSU_Projects', [...value, projectData], () => {
        logger.log('info', `Successfully created project: ${projectData.title} with UUID: ${projectData.ID}`)
      })
    }
  })
}

localforage.ready().then(() => {
  logger.log('info', `Localforage initialised! Using Storage Driver: ${localforage.driver()}`)
  window.loadProjects = loadProjects
  window.projectsAPI = {}
  window.projectsAPI.createProject = createProject
  window.projectsAPI.deleteScript = deleteScript
  window.projectsAPI.getScript = getScript
}).catch(function (e) {
  logger.log('error', `LocalForage could not be initialised! ${e}`)
})
