const path = require('path')

module.exports = {
    entry: './src/assets/javascripts/index.js',
    output: {
        path: path.resolve(__dirname, './src/public'),
        filename: 'app.js',
    },
    module: {
        loaders: [
            {
                test: /\.js$/,
                exclude: /node_modules/,
                loader: 'babel-loader'
            },
            {
                test: /\.scss$/,
                loader: 'style-loader!css-loader!sass-loader'
            }
        ]
    }
}
