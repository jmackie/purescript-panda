const path = require("path");
const HtmlWebpackPlugin = require("html-webpack-plugin");

module.exports = {
  mode: "development",
  context: __dirname,
  entry: {
    counter: path.resolve(__dirname, "counter/index.js")
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
              psc: "psa",
              src: [
                "./.spago/*/*/src/**/*.purs",
                "../src/**/*.purs",
                "./counter/**/*.purs"
              ]
            }
          }
        ]
      }
    ]
  },
  plugins: [
    new HtmlWebpackPlugin({
      title: "counter",
      chunks: ["counter"],
      filename: "counter.html"
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
    port: 8080,
    stats: "errors-only",
    progress: true,
    inline: true,
    hot: true
  }
};
