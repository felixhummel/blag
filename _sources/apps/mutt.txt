Mutt How To Mirror
==================
Original How To by Andrew Strong on Ubuntuforums.

::


    Introduction
    ================

    This page is a guide to using the email client Mutt to send, receive and read email under Ubuntu using a Gmail account as a relay. It has been tested and extensively used under Ubuntu Oneiric Ocelot. There are a few steps involved but if followed carefully and in sequence you will soon be using Mutt successfully with your Gmail account.
     
    In sequence we will:

    [*]Introduce John!
    [*]Introduce vim
    [*]Set up SSL
    [*]Set up msmtp
    [*]Set up Fetchmail
    [*]Set up Procmail
    [*]Set up Mutt

    =====================
    1. Introducing John ...
    =====================

    To avoid confusion in editing the many configuration files involved in this setup I will describe the setup of mutt and gmail for my new friend John, who has been borrowed from this guide's [URL="http://www.andrews-corner.org/mutt.html"]big brother[/URL]. John's details are as follows:

    [CODE]Gmail Address:        john.example@gmail.com
    Gmail Password:       rover
    Computer Username:    john [/CODE]

    John's details will always be in italics, bold and in red to remind you, Gentle Reader, to substitute your details for his. Hopefully this will lessen the confusion that I have unintentionally created with older versions of this page!

    Now to introduce one of my best friends: vim...

    =====================
    2. Introducing vim ...
    =====================

    I have been somewhat taken to task for throwing vim into this guide without too much warning, for which my apologies to all. vim is the text editor that I feel suits mutt the best but a little preparation is a good idea before launching straight into it. Download vim from the repository as follows:

    [CODE]sudo apt-get install vim[/CODE]

    and once vim is installed run through the builtin tutorial by simply running:

    [CODE]vimtutor[/CODE]

    It may take a little time to come to grips with this great editor but trust me it is time well spent. For those who find it all a little hard there is always nano or pico!

    Now lets get started with SSL:

    ============
    3. SSL Tools
    ============

    Gmail uses the POP3-over-SSL protocol to protect the transmission of username and password over the Internet. You will need to install both open SSL and a certificate pack from the repository as follows:

    [code]$ sudo apt-get install openssl ca-certificates[/code]

    Later you will need to add the necessary SSL instructions to Fetchmail, but the next step is to install the software to send mail from your computer to the server: ssmtp.

    =========
    4. msmtp
    =========

    msmtp is a great and wonderfully reliable way to move mail from your computer. Download it from the repository as follows:

    [code]$ sudo apt-get install msmtp[/code]

    There is a single configuration file to be altered: $HOME/.msmtprc. It can be created and permissions set as follows:

    [code]$ touch $HOME/.msmtprc
    $ touch $HOME/.msmtp.log
    $ chmod 0600 $HOME/.msmtprc[/code]

    Below is the required configuration for a Gmail server:

    [CODE]account default              
    host smtp.gmail.com          
    port 587                     
    from [I][COLOR="Red"]john.example@gmail.com [/COLOR] [/I]  
    tls on                       
    tls_starttls on              
    tls_trust_file /etc/ssl/certs/ca-certificates.crt
    auth on                     
    user [I][COLOR="Red"]john.example[/COLOR] [/I]      
    password [I][COLOR="Red"]rover[/COLOR] [/I]      
    logfile ~/.msmtp.log[/CODE]

    Now to setup Fetchmail:

    ============
    5. Fetchmail
    ============

    Fetchmail is great tool to download mail from Gmail. Download it from the repository as follows:

    [code]$ sudo apt-get install fetchmail[/code]

    Once again a single configuration file is required and so you will need to create ~/.fetchmailrc as follows:

    [code] $ vim ~/.fetchmailrc [/code]

    The following configuration allow Fetchmail to access and fetch email from Gmail, leave a copy of the mail on the Gmail server and pass the mail to Procmail on your local machine. The SSL configuration is included here as well:

    [CODE]
    poll pop.gmail.com                   
    with proto POP3                      
    user '[I][COLOR="Red"]john.example@gmail.com[/COLOR][/I]'        
    there with password '[I][COLOR="Red"]rover[/COLOR][/I]'        
    is '[I][COLOR="Red"]john[/COLOR][/I]' here                              
    mda "/usr/bin/procmail -d %T"        
    options                                                             
    no keep                                 
    ssl                                  
    sslcertck                            
    sslcertpath /etc/ssl/certs
    [/CODE]

    All done except as a final touch, since the username and password are openly in this file,you will need to make the file readable only by the file owner. If this is not done Fetchmail will not even run:

    [code] $ chmod 600 ~/.fetchmailrc[/code]

    Now would be a good to time to make sure you have [URL="http://gmail.google.com/support/bin/answer.py?answer=13273"]POP forwarding enabled[/URL] in your Gmail account. You will find this in: Settings - Forwarding and POP.  Note also that Gmail has a little oddity in regard to the "keep" and "nokeep" command of Fetchmail. You cannot remove mail from Gmail servers via POP3 but you can choose to have your messages archived, kept or deleted once they have been downloaded via POP3. This is a Gmail setting hidden in Settings - Forwarding and POP: "When messages are accessed with POP...".

    Now for the mail delivery program Procmail:

    ===========
    6. Procmail
    ===========

    Procmail is great sorting tool for use with any mail setup. It can be easily downloaded from the repository:

    [code]$ sudo apt-get install procmail[/code]

    So where will Procmail deliver to? Traditionally all mail goes to the location specified in the $MAIL environment variable, but in a default Ubuntu system this is often not set. Set the MAIL variable by opening ~/.bashrc as follows:

    [code] $ vim ~/.bashrc [/code]

    and adding the following, using your [I]own[/I] username:

    [code]# Sets the Mail Environment Variable
    MAIL=/var/spool/mail/[I][COLOR="Red"]john[/COLOR][/I] && export MAIL[/code]

    A very simple configuration file must be created for procmail as follows:

    [code]$ vim ~/.procmailrc [/code]

    and below is a very simple start to what can be quite a complex file:

    [code]# Environment variable assignments
    PATH=/bin:/usr/bin:/usr/local/bin 
    VERBOSE=off                   # Turn on for verbose log
    MAILDIR=$HOME/Mail            # Where Procmail recipes deliver
    LOGFILE=$HOME/.procmaillog    # Keep a log for troubleshooting.
    # Recipes
    :0:
    * ^TOmutt-user
    mutt[/code]

    I include a very simple sorting recipe with the file: this one intercepts everything addressed to "mutt-user" and directs it to $HOME/Mail/mutt. This is the mutt-user mailing list which I would advise all new mutt users to join. And lets not forget to create the Mail folder:

    [code]$ mkdir $HOME/Mail [/code]

    Now finally to Mutt.

    =======
    7. Mutt
    =======

    Mutt is one of the truly great pieces of software under Linux. The following command downloads Mutt from the Ubuntu repository:

    [code]$ sudo apt-get install mutt[/code]

    Mutt is driven by a configuration file that can be created as follows:

    [code]$ vim ~/.muttrc [/code]

    I have spent some time building this file from scratch but for you, Gentle Reader, I include here a more basic version, similar to the one I started from:

    [code]#======================================================#
    # Boring details
    set realname = "[I][COLOR="Red"]john[/COLOR][/I]"
    set from = "[I][COLOR="Red"]john.example@gmail.com[/COLOR][/I]"
    set use_from = yes
    set envelope_from ="yes"
    set sendmail="/usr/bin/msmtp"

    # If not set in environment variables:
    set spoolfile = /var/spool/mail/[I][COLOR="Red"]john[/COLOR][/I]

    #======================================================#
    # Folders
    set folder="~/Mail"                # Mailboxes in here
    set record="+sent"                 # where to store sent messages
    set postponed="+postponed"         # where to store draft messages
    set move=no                        # Don't move mail from the spool.

    #======================================================#
    # Watch these mailboxes for new mail:
    mailboxes ! +Fetchmail +slrn +mutt
    set sort_browser=alpha    # Sort mailboxes by alpha(bet)

    #======================================================#
    # Order of headers and what to show
    hdr_order Date: From: User-Agent: X-Mailer \
              To: Cc: Reply-To: Subject:
    ignore *
    unignore Date: From: User-Agent: X-Mailer  \
             To: Cc: Reply-To: Subject:
                   
    #======================================================#
    # which editor do you want to use? 
    # vim of course!
    set editor="vim -c 'set tw=70 et' '+/^$' " 
    set edit_headers          # See the headers when editing

    #======================================================#
    # Aliases

    set sort_alias=alias     # sort aliases in alpha order by alias name

    #======================================================#
    # Odds and ends
    set markers          # mark wrapped lines of text in the pager with a +
    set smart_wrap       # Don't wrap mid-word
    set pager_context=5  # Retain 5 lines of previous page when scrolling.
    set status_on_top    # Status bar on top.
    push <show-version>  # Shows mutt version at startup[/code]

    Note:  Procmail will create your mailbox in the spool, and set the appropriate permissions, when it first receives mail from fetchmail so don't worry that mutt cannot [I]initially[/I] find this mailbox. If you wish to create the mailbox yourself the following permissions and ownership are required (taken from my [I]own[/I] system):

    [CODE]-rw-rw---- 1 [COLOR="Red"]andrew[/COLOR] mail 0 2008-10-23 10:12 /var/spool/mail/[COLOR="Red"]andrew[/COLOR][/CODE]

    And finally it is reward time as you open Mutt, type ! to open a shell prompt, type fetchmail -v and start reading your mail! My parting gift is a little macro that was written for me by a generous person on the mutt-user mailing list that will actually do this for you when you simply press the key "I". Place the following in your ~/.muttrc file:

    [code]macro index,pager I '<shell-escape> fetchmail -v<enter>'[/code]

    And welcome to the world of mutt!

    January 12th 2012
    Andrew Strong
