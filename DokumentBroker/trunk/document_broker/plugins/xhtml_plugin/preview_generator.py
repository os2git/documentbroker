# Copyright (C) 2012  Magenta ApS.
#
# Authors: Carsten Agger (carstena@magenta-aps.dk),
#          Dennis Isaksen (dennis@magenta-aps.dk),
#          Leif Lodahl (leif@magenta-aps.dk)
#
# This file is part of the Magenta Document Broker.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranties of
# MERCHANTABILITY, SATISFACTORY QUALITY, or FITNESS FOR A PARTICULAR
# PURPOSE.  See the Mozilla Public License for more details.

import os
import subprocess
import client.document_broker_settings as settings


class ImagePreview:
    def __whiteSpaceSeparateFiles(self, files):
        """
        We separate the file name by white spaces as needed in command
        line arguments.
        """
        space_sep_files = files[0] + " "
        for i, f in enumerate(files):
            if i > 0:
                space_sep_files += f
                if i < (len(files) - 1):
                    space_sep_files += " "
        return space_sep_files

    def __call_fop(self, xhtml, doc_type, resolusion, destination, folder,
            extension):
        #TODO:
        #Exceptions should be handled and logged to track eventual
        #errors.

        """
        FOP is called to produce the snapshots as specified by the
        parameters.
        """
        executable = "fop"
        config = "-c"
        config_file = os.path.join(os.path.dirname(os.path.abspath(__file__)),
            "fop.xconf")
        accessibility = "-a"

        """
        A decision of which template input to use is made
        """
        if extension == ".fo":
            input_format = "-fo"
        else:
            input_format = "-xml"

        infile = "-"
        xslt = "-xsl"
        xslt_file = os.path.join(os.path.dirname(os.path.abspath(__file__)),
            "xslt_default.xsl")
        """
        pdf = "-pdf"
        output_file = pdf_file
        pdfprofile = "-pdfprofile"
        pdf_a_1a = "PDF/A-1a"
        """
        #
        # TIFF generation requires extra libraries included with FOP, so
        # that will be kept out for now.
        #
        """
        if doc_type != "tiff":
            img_type = "-png"
            extension = "png"
        else:
            img_type = "-tiff"
            extension = "tiff"
        """
        img_type = "-png"
        extension = "png"
        output_file = destination + "." + extension
        res_spec = "-dpi"
        args = [executable, config, config_file, accessibility,
            input_format, infile,
            xslt, xslt_file, img_type, output_file, res_spec, str(resolusion)]
        p = subprocess.Popen(args, stdin=subprocess.PIPE)
        xhtml = xhtml.decode('utf8')
        xhtml = xhtml.encode('utf8')
        p.stdin.write(xhtml)
        p.communicate()
        p.stdin.close()
        temp_id = destination[(destination.rfind("/") + 1):]
        if doc_type == "tiff":
            """
            We just return the file as only one tiff file is produced.
            """
            return "{0}.{1}".format(temp_id, img_type)
        elif doc_type == "example" or doc_type == "thumbnail":
            """
            We do a little clean up. FOP produces a list of files:
                x.png x2.png x3.png etc.
            We only want one single image. Thus we run the command
            specified in the line underneath to achieve this.
            And furthermore we want to extend the name with "_example" so
            that we can keep track with the images associated with a template.
            """
            subprocess.call(
                "cd {0} && cp {1}.png tmp && rm {1}* && cp tmp {1}.png"
                " && rm tmp"
                .format(folder, destination), shell=True
            )
            return subprocess.check_output("cd {0} && ls {1}*"
                .format(folder, destination), shell=True).split()
        elif doc_type != "png":
            """
            We do a little clean up. FOP produces a list of files:
            x.png x2.png x3.png etc.
            We would like that to be: x1.png x2.png x3.png etc. Thus we
            run the command specified in the line underneath to achieve this.
            """
            subprocess.call("cd {0} && cp {1}.{2} {1}1.{2} && rm {1}.{2}"
                .format(folder, temp_id, extension), shell=True
            )
            return subprocess.check_output("cd {0} && ls {1}*"
                .format(folder, temp_id), shell=True).split()
        else:
            """
            We do a little clean up. FOP produces a list of files:
                x.png x2.png x3.png etc.
            We only want one single image. Thus we run the command
            specified in the line underneath to achieve this.
            """
            subprocess.call(
                "cd {0} && cp {1}.png tmp && rm {1}* && cp tmp {1}.png"
                " && rm tmp"
                .format(folder, temp_id), shell=True
            )
            return "{0}.{1}".format(temp_id, img_type)

    def __bundled_preview(self, xhtml, doc_type, resolusion, destination,
            extension):
        """
        A bundled file is requested, so we use tar or zip to
        compress with the desired format.
        """
        image_destination = destination[:destination.rfind(".")]
        destination_folder = destination[:destination.rfind("/")]
        temp_id = destination[(destination.rfind("/") + 1):]
        files = ImagePreview().__call_fop(
            xhtml, doc_type, resolusion,
            image_destination, destination_folder, extension
        )
        if doc_type != "html":
            command = ""
            if doc_type == "tar":
                command = "tar cf "
            if doc_type == "tar.gz" or doc_type == "tar.bz2":
                command = "tar cfa"
            if doc_type == "zip":
                command = "zip"
            subprocess.call(
                "cd {1} && {0} {2} {3}".format(command,
                destination_folder, temp_id,
                ImagePreview().__whiteSpaceSeparateFiles(files)),
                shell=True
            )
            """Afterwards we remove the image files."""
            for f in files:
                subprocess.call(
                    "cd {1} && rm {0}".format(f,
                    destination_folder), shell=True
                )
        else:
            """
            An HTML file is requested, so we generate one.
            """
            html = "<html><head><title>preview of {}".format(temp_id)
            html += "</title></head><body>"
            """
            We traverse the file list and insert the paths into IMG tags
            in the HTML document.
            """
            index = 1
            for f in files:
                html += "<img style='display: block; margin-left: auto; "
                html += "margin-right: auto;' "
                html += "src='{}' alt='image #{}'/>".format(f, index)
                index += 1
            html += "</body></html>"
            with open(image_destination + ".html", "w") as html_file:
                html_file.write(html)
            """
            Finally we set the doc_type to html, so the returned file
            extension will be correct.
            """
            doc_type = "html"
            return "{0}.{1}".format(temp_id, doc_type)

    def __unbundled_preview(self, xhtml, doc_type, resolusion, destination,
            extension):
        """
        No bundling is requested, so we just return the files as a
        comma separated list.
        """
        image_destination = destination[:destination.rfind(".")]
        destination_folder = destination[:(destination.rfind("/") + 1)]
        files = ImagePreview().__call_fop(
            xhtml, doc_type, resolusion,
            image_destination, destination_folder, extension
        )
        if len(files) > 1:
            """ We have a list of files and thus separate them by commas. """
            comm_sep_files = files[0] + ","
            for index, file in enumerate(files):
                if index > 0:
                    comm_sep_files += file
                    if index < (len(files) - 1):
                        comm_sep_files += ","
            return comm_sep_files
        else:
            """ We only have one file and return it. """
            return files

    @classmethod
    def generate_preview(self, xhtml, destination, return_format, resolusion,
            extension):
        if (
                return_format == "tar"
                or return_format == "tar.gz"
                or return_format == "tar.bz2"
                or return_format == "html"
                or return_format == "zip"
        ):
            return ImagePreview().__bundled_preview(
                xhtml, return_format,
                resolusion, destination, extension
            )
        elif return_format == "tiff" or return_format == "png":
            return ImagePreview().__unbundled_preview(
                xhtml, return_format, resolusion, destination, extension
            )

    @classmethod
    def generate_template_image(self, xhtml, destination, image_type,
            resolusion, extension):
        """
        For now this method only returns png-images. In the future it might be
        necessary to support other image formats as well but until that we
        will not provide that option.
        """
        return ImagePreview().__unbundled_preview(
            xhtml, image_type, resolusion, destination, extension
        )

    @classmethod
    def get_preview_files(self, doc_type, bundling, resolusion, uid,
        return_type):
        #TODO:
        #This method is unused so far because further changes has to be
        #done to the result page.
        """
        This method vil produce snapshots of a document and return
        paths to the created files.
        """

        #TODO:  return type is not implemented yet. The method should
        #       be able to return data in a standardized way like json,
        #       xml or maybe just the data right away.
        #       At the moment data is just returned as a comma separated
        #       list of files.

        if (
                bundling == "tar"
                or bundling == "tar.gz"
                or bundling == "tar.bz2"
                or bundling == "zip"
        ):
            file_string = ImagePreview().__bundled_preview(
                doc_type, bundling, resolusion, uid
            )
        elif bundling == "unbundled":
            file_string = ImagePreview().__unbundled_preview(
                doc_type, resolusion, uid
            )
        else:
            file_string = "ERROR: invalid argument. Supported are: unbundled, "
            file_string += "tar, tar.gz, tar.bz2 and zip"
        return file_string
