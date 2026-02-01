(os/setenv "TZ" "America/New_York")

(def args (dyn :args))
(def targets (if (> length args) 1) (args 1) ".")

(def time (os/strftime "%Y-%m-%d_%a_%I-%M %p" (os/time) true))
(def output-file (string "/Users/nickstrakhov/Downloads/contents_" time ".md"))

(defn walk-dir [path]
    (each file (os/dir path)
        (def full-path (string path "/" file))
        (def mode (os/stat full-path :mode))
        (cond
            (= mode :file)
            (do 
                (def contents (slurp full-path))
                (spit output-file
                    (string "## " full-path "\n\n```\n" contents "\n```\n\n")
                    :a))
                
                (= mode :directory)
                (walk-dir full-path))))

(walk-dir target-dir)