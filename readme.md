# Document Generator

This tool is for converting online markdown in to docx using specified template.

## Usage:

>.\generate-document.ps1 **[URL]** **[output\_path]** *[template\_path]* *[image_width]*

## Example

>.\generate-document.ps1 https://gist.github.com/mrkaminski77/d119adde2559c0d
37e7fdeeca9b42919/raw/fbae71e713df3b4ce13cb05963db11c82e38ef03/design-doc.md H:\Serco.dotx test.docx

## Notes

You will need to correct the installation path of the node package in the convert.js file.

If you don't have node-js installed request from IT or consult David Kaminski.

You will also need markdown-it installed.
>npm install -g markdown-it
