(defmodule lfetool
  (export all))

(defun init ()
  (lfetool-plugin:load-plugins)
  (lfetool-util:setup-dirs)
  (if (lfetool-util:debug?) (lfetool-util:display-stats)))

(defun start ()
  (init))

(defun eval (cmd-string)
  (apply
    #'dispatch/1
    `(,(parse cmd-string))))

(defun tokenize (cmd-string)
  (string:tokens
    cmd-string
    (lfetool-const:cmd-sep)))

(defun parse (cmd-string)
  `#(ok ,(lists:map
           (lambda (x)
            (list_to_atom x))
           (tokenize cmd-string))))

(defun dispatch (data)
  (-dispatch data))

(defun -dispatch
  ;; The first stage that lfetool does is parse command line parameters that
  ;; were passed to the bootstraper shell script. If there was a problem, we'll
  ;; see an #(error ...) tuple. If it goes okay, we continue to dispatch.
  (((tuple 'ok parsed-args))
    (command-dispatch parsed-args))
  (((tuple 'error error-data))
    (lfetool-err:display error-data)))

(defun command-dispatch
  (((list))
   (non-plugin-dispatch 'usage))
  (((list command))
    (non-plugin-dispatch command))
  (((= (cons command _) args))
    (plugin-dispatch args)))

(defun non-plugin-dispatch (command)
  (try
    (call-cmd command)
    (catch
      ((= (tuple 'error _ _) error-data)
        (handle-bad-non-plugin-command command error-data)))))

(defun plugin-dispatch
  (((list 'new plugin project-name))
   (try
    (call-new plugin project-name)
    (catch
      ((= (tuple 'error _ _) error-data)
        (handle-bad-plugin-or-func plugin project-name error-data)))))
  (((= (cons command (cons plugin args)) all))
    (cond
      ((lfetool-inspect:not-command? command)
        (handle-bad-plugin-command command plugin))
      ((lfetool-inspect:not-plugin? plugin)
        (handle-bad-plugin plugin))
      ('true
        (handle-bad-arg-count command plugin args)))))

(defun call-cmd (command)
  (lfetool-util:display (call 'lfetool-cmd command)))

(defun call-new (plugin project-name)
  (let ((module (lfetool-plugin:get-plugin-module plugin)))
    (lfetool-util:display (call module 'new project-name))))

(defun handle-bad-non-plugin-command (command error-data)
  (if (lfetool-util:debug?)
        (lfetool-err:display
          "Command call" "unknown command" error-data)
      (lfetool-util:display-str
        (++ "\nUnknown command: '" (atom_to_list command) "'\n\n"
            (lfetool-cmd:usage)))))

(defun handle-bad-plugin-or-func (plugin project-name error-data)
  (if (lfetool-util:debug?)
        (lfetool-err:display
          "Plugin call" "unknown plugin or plugin function" error-data)
      (lfetool-util:display-str
        (++ "\nUnknown plugin (or plugin function): '"
            (atom_to_list plugin) ":" (atom_to_list project-name)
            "'\n\n" (lfetool-cmd:commands)))))

(defun handle-bad-plugin-command (command plugin)
  (let ((module (lfetool-plugin:get-plugin-module plugin))
        (plugin (atom_to_list plugin)))
    (if (lfetool-util:debug?)
          (lfetool-err:display
            "unknown plugin command: " (list command))
        (lfetool-util:display-str
          (++ "\nPlugin '" plugin "' doesn't support command '"
              (atom_to_list command) "'.\n\nHelp for '" plugin "' plugin:\n\n"
              (call module 'get-help))))))

(defun handle-bad-plugin (plugin)
  (if (lfetool-util:debug?)
        (lfetool-err:display
          "unknown plugin." (list plugin))
      (lfetool-util:display-str
        (++ "\nUnknown plugin: '"
            (atom_to_list plugin) "'\n\n" (lfetool-cmd:commands)))))

(defun handle-bad-arg-count (command plugin args)
  (let ((module (lfetool-plugin:get-plugin-module plugin))
        (command (atom_to_list command))
        (plugin (atom_to_list plugin)))
    (if (lfetool-util:debug?)
          (lfetool-util:display-str
            (++ "Error: command '" command "' called on plugin '"
                plugin "' with wrong number of args: ("
                (lfetool-util:join-list args) ")"))
        (lfetool-util:display-str
          (++ "\nWrong number of args for command '" command
              "' called on plugin '" plugin "': ("
              (lfetool-util:join-list args) ")\n\n"
              "Help for '" plugin "' plugin:\n\n"
              (call module 'get-help))))))
