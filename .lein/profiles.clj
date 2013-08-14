{:user {:aliases {"math" ["with-profile" "+math" "repl"]}
        :plugins [[lein-shell "0.2.0"]
                  [lein-miditest "0.1.0"]]}
 :math {:dependencies [[org.clojure/math.combinatorics "0.0.2"]
                       [org.clojure/math.numeric-tower "0.0.1"]
                       [org.clojure/tools.trace "0.7.3"]]
        :repl-options {:init (do (use 'clojure.math.combinatorics
                                      'clojure.math.numeric-tower
                                      'clojure.tools.trace)
                                 (require '[clojure.pprint
                                            :refer [pprint cl-format]]))}}}
