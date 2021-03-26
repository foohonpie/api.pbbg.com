const EMAIL = 'Email'
const PASSWORD = 'Password'

const fields = {
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
}

const rules = {
  [EMAIL]: val => {
    const re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
    return re.test(String(val).toLowerCase()) || 'Must be a valid email address.'
  },
  [PASSWORD]: val => (val && val.length > 3) || 'Password must be longer than 3 characters.',
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
      // TODO do something with formModels
      console.log(formModels)
    },
  }],
}
