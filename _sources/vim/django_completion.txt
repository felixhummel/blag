Vim auto completion for Django in a virtualenv
==============================================
.. highlight:: vim

The title says it all. Daniel Roseman's `post <http://blog.roseman.org.uk/2010/04/21/vim-autocomplete-django-and-virtualenv/>`__ helped me a lot. Here is my attempt of a slightly more automatic way::

    " Sets up omni-completion for a django project in a virtualenv.                
    "
    " Copy this file to YOUR_VIRTUALENV_DIR/.vimrc and add the following to your   
    " ~/.vimrc file:       
    "     if filereadable($VIRTUAL_ENV . '/.vimrc')                                
    "         source $VIRTUAL_ENV/.vimrc                                           
    "     endif
    "                                                                              
    " Thanks, Daniel!
    " http://blog.roseman.org.uk/2010/04/21/vim-autocomplete-django-and-virtualenv/
        
    py << EOF
    import os.path                                                                 
    import sys                                                                     
    import vim

    # SET THIS MANUALLY
    # =================
    DJANGO_SETTINGS_MODULE='foo.settings'                                          

    project_base_dir = os.environ['VIRTUAL_ENV']

    sys.path.insert(0, project_base_dir)                                           

    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')         
    execfile(activate_this, dict(__file__=activate_this))                          

    os.environ['DJANGO_SETTINGS_MODULE'] = DJANGO_SETTINGS_MODULE                  
    EOF 

All you need to do is set the DJANGO_SETTINGS_MODULE variable.
