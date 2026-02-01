(os/setenv "TZ" "America/New_York")

(def args (dyn :args))
(def targets 
    (cond
        (= (length args) 1) @["."]
        (= (length args) 2) @[(args 1)]
        (> (length args) 2) (array/slice args 1)))

(def binary-extensions @[".png" ".jpg" ".gif" ".pdf" ".zip" ".exe" ".bin" ".o" ".pyc" ".db" ".sqlite" ".sqlite3"])
(defn binary-file? [filename]
    (some |(string/has-suffix? $ filename) binary-extensions))

(def skip-dirs @[".git" "node_modules" ".venv" "__pycache__" ".DS_Store" "tmp"])
(defn skip-dir? [dirname]
    (some |(= $ dirname) skip-dirs))

(def time (os/strftime "%Y-%m-%d_%a_%I-%M_%p" (os/time) true))
(def output-file (string "/Users/nickstrakhov/Downloads/contents_" time ".md"))

(defn walk-dir [path]
    (each file (os/dir path)
        (unless (string/has-suffix? "." file)
            (def full-path (string path "/" file))
            (def mode (os/stat full-path :mode))
            (cond
                (and (= mode :file) (not (binary-file? file)))
                (do 
                    (def contents (slurp full-path))
                    (spit output-file
                        (string "## " full-path "\n\n```\n" contents "\n```\n\n")
                        :a))
                    
                (and (= mode :directory) (not (skip-dir? file)))
                (walk-dir full-path)))))

(each dir targets
    (walk-dir dir))