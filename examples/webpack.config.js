const path = require("path");
const HtmlWebpackPlugin = require("html-webpack-plugin");

module.exports = {
  mode: "development",
  context: __dirname,
  entry: {
    button: path.resolve(__dirname, "button/index.js")
    //todo: path.resolve(__dirname, "todo/index.js")
  },
  output: {
    path: path.resolve(__dirname, "dist"),
    filename: "[name].js"
  },
  module: {
    rules: [
      {
        test: /\.purs$/,
        exclude: /node_modules/,
        use: [
          {
            loader: "purs-loader",
            options: {
              psa: true,
              src: [
                "./.spago/*/*/src/**/*.purs",
                "../src/**/*.purs",
                "./button/**/*.purs"
              ]
            }
          }
        ]
      }
    ]
  },
  plugins: [
    new HtmlWebpackPlugin({
      title: "Example: button",
      chunks: ["button"],
      filename: "button.html"
    })
    //new HtmlWebpackPlugin({
    //  title: "Example: todo",
    //  chunks: ["todo"],
    //  filename: "todo.html"
    //})
  ],
  devServer: {
    publicPath: "/",
    contentBase: path.resolve(__dirname, "dist"),
    hot: true
  }
};
