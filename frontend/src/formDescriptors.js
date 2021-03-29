import store, { SUBMITTED_USER_LOGIN_ACTION, SUBMITTED_USER_REGISTER_ACTION } from './store'

export const NAME = 'Name'
export const EMAIL = 'Email'
export const PASSWORD = 'Password'
export const CONFIRM_PASSWORD = 'Confirm Password'

const fields = {
  [NAME]: {
    type: 'string',
    title: NAME,
    description: 'Enter your name.',
    examples: ['JimmehBoy'],
    'x-rules': val => (val && val.length > 3) || 'Name must be longer than 3 characters.',
  },
  [EMAIL]: {
    type: 'string',
    title: EMAIL,
    description: 'Enter your email address.',
    examples: ['john@gmail.com'],
    'x-rules': [EMAIL],
  },
  [PASSWORD]: {
    type: 'string',
    title: PASSWORD,
    description: 'Enter your password.',
    'x-rules': [PASSWORD],
  },
  [CONFIRM_PASSWORD]: {
    type: 'string',
    title: CONFIRM_PASSWORD,
    description: 'Confirm your password.',
    'x-rules': [CONFIRM_PASSWORD],
  },
}

let current_password_temp = null
function isValidPassword(val) {
  if (val && val.length > 3) {
    current_password_temp = val
    if (String(val).toLowerCase() === String(current_password_temp).toLowerCase()) {
      current_password_temp = null
      return true
    }
    return 'Passwords must match.'
  }
  return 'Password must be longer than 3 characters.'
}

const rules = {
  [EMAIL]: val => {
    const re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
    return re.test(String(val).toLowerCase()) || 'Must be a valid email address.'
  },
  [PASSWORD]: isValidPassword,
  [CONFIRM_PASSWORD]: isValidPassword,
}

// Form Descriptors (for generating forms from Object Descriptors) must consist of:
// 'schema',
// 'model',
// 'options',
// 'buttons'
export const userLoginForm = {
  models: {
    [EMAIL]: null,
    [PASSWORD]: null,
  },
  schema: {
    type: 'object',
    required: [EMAIL, PASSWORD],
    properties: {
      [EMAIL]: {...fields[EMAIL]},
      [PASSWORD]: {...fields[PASSWORD]},
    },
  },
  options: {
    rules: {
      [EMAIL]: rules[EMAIL],
      [PASSWORD]: rules[PASSWORD],
    },
  },
  buttons: [{
    type: 'submit',
    color: 'primary',
    styleClasses: [''],
    buttonText: 'Submit',
    disableWhenInvalidForm: true,
    clickHandler: (formModels) => {
      store.dispatch(SUBMITTED_USER_LOGIN_ACTION, formModels)
    },
  }],
}

export const userRegisterForm = {
  models: {
    [NAME]: null,
    [EMAIL]: null,
    [PASSWORD]: null,
    [CONFIRM_PASSWORD]: null,
  },
  schema: {
    type: 'object',
    required: [NAME, EMAIL, PASSWORD, CONFIRM_PASSWORD],
    properties: {
      [NAME]: {...fields[NAME]},
      [EMAIL]: {...fields[EMAIL]},
      [PASSWORD]: {...fields[PASSWORD]},
      [CONFIRM_PASSWORD]: {...fields[CONFIRM_PASSWORD]},
    },
  },
  options: {
    rules: {
      [EMAIL]: rules[EMAIL],
      [PASSWORD]: rules[PASSWORD],
      [CONFIRM_PASSWORD]: rules[CONFIRM_PASSWORD],
    },
  },
  buttons: [{
    type: 'submit',
    color: 'primary',
    styleClasses: [''],
    buttonText: 'Submit',
    disableWhenInvalidForm: true,
    clickHandler: (formModels) => {
      store.dispatch(SUBMITTED_USER_REGISTER_ACTION, formModels)
    },
  }],
}
