# Getting Started with Create React App

```
│── .gitignore
│── Dockerfile
│── Jenkinsfile
│── package.json
│── README.md
│
├── 📂 helm
│   ├── 📂 cassandra-cluster
│   │   │── Chart.yaml
│   │   │── values.yaml
│   │   │
│   │   ├── 📂 charts
│   │   ├── 📂 templates
│   │   │   │── deployment.yaml
│   │   │   │── hpa.yaml
│   │   │   │── service.yaml
│   │   │   │── service_external.yaml
│   │   │   │── statefulsets.yaml
│   │   │   │── _helpers.tpl
│   │
│   ├── 📂 react-app
│   │   │── Chart.yaml
│   │   │── values.yaml
│   │   │
│   │   ├── 📂 templates
│   │   │   │── deployment-canary.yaml
│   │   │   │── deployment-stable.yaml
│   │   │   │── ingress.yaml
│   │   │   │── service.yaml
│   │   │   │── _helper.tpl
│
├── 📂 public
│   │── favicon.ico
│   │── index.html
│   │── logo192.png
│   │── logo512.png
│   │── manifest.json
│   │── robots.txt
│
└── 📂 src
    │── App.css
    │── App.js
    │── App.test.js
    │── index.css
    │── index.js
    │── logo.svg
    │── reportWebVitals.js
    │── setupTests.js
    │
    ├── 📂 components
    │   ├── 📂 Header
    │   │   │── Headerbar.jsx
    │   │   │── index.js
    │   │
    │   ├── 📂 NewTask
    │   │   │── Form.jsx
    │   │   │── index.js
    │   │   │── style.css
    │   │
    │   ├── 📂 TaskList
    │       │── index.js
    │       │── List.jsx
    │       │── ListItem.jsx
    │       │── style.css

```


### `npm start`

Runs the app in the development mode.\
Open [http://localhost:3000](http://localhost:3000) to view it in your browser.

The page will reload when you make changes.

### `npm test`


### `npm run build`

Builds the app for production to the `build` folder.\
It correctly bundles React in production mode and optimizes the build for the best performance.

Your app is ready to be deployed!

See the section about [deployment](https://facebook.github.io/create-react-app/docs/deployment) for more information.

### `npm run eject`

**Note: this is a one-way operation. Once you `eject`, you can't go back!**

If you aren't satisfied with the build tool and configuration choices, you can `eject` at any time. This command will remove the single build dependency from your project.

Instead, it will copy all the configuration files and the transitive dependencies (webpack, Babel, ESLint, etc) right into your project so you have full control over them. All of the commands except `eject` will still work, but they will point to the copied scripts so you can tweak them. At this point you're on your own.


## Learn More

You can learn more in the [Create React App documentation](https://facebook.github.io/create-react-app/docs/getting-started).

To learn React, check out the [React documentation](https://reactjs.org/).

### Code Splitting

This section has moved here: [https://facebook.github.io/create-react-app/docs/code-splitting](https://facebook.github.io/create-react-app/docs/code-splitting)


### `npm run build` failto minify
