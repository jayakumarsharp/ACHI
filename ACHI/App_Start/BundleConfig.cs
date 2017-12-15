using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;

namespace CRUserManagement.App_Start
{
    public class BundleConfig
    {
        public static void RegisterBundles(BundleCollection bundles)
        {

            //bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
            //            "~/plugins/moment.js",
            //            "~/Lib/bootstrap.js",
            //            "~/plugins/moment.js",
            //            "~/Lib/jquery-1.11.0.min.js",
            //            "~/Lib/bootstrap-datetimepicker.js",
            //            "~/Lib/jquery.dataTables.min.js",
            //            "~/Lib/angular.min.js",
            //            "~/Lib/angulardatatabes.js",
            //            "~/Assert/angular-animate.min.js",
            //             "~/Assert/toaster.js",
            //             "~/plugins/ng-file-upload/dist/ng-file-upload.min.js",
            //             "~/plugins/ng-file-upload/dist/ng-file-upload-shim.min.js"
            //            ));



            //bundles.Add(new ScriptBundle("~/bundles/bootstrap").Include(
            //        "~/Scripts/bootstrap.min.js",
            //            "~/Scripts/bootstrap-multiselect.js",
            //           "~/Scripts/custom.js"
            //            ));
            bundles.Add(new ScriptBundle("~/bundles/customscripts").Include(
                     "~/plugins/moment.js",
                        "~/Lib/bootstrap.js",
                        "~/plugins/moment.js",
                        "~/Lib/jquery-1.11.0.min.js",
                        "~/Lib/bootstrap-datetimepicker.js",
                        "~/Lib/jquery.dataTables.min.js",
                        "~/Lib/angular.min.js",
                        "~/Lib/angulardatatabes.js",
                        "~/Assert/angular-animate.min.js",
                         "~/Assert/toaster.js",
                         "~/plugins/ng-file-upload/dist/ng-file-upload.min.js",
                         "~/plugins/ng-file-upload/dist/ng-file-upload-shim.min.js"

                    ));

            const string ANGULAR_APP_ROOT = "~/js/";
            const string VIRTUAL_BUNDLE_PATH = ANGULAR_APP_ROOT + "main.js";

            var scriptBundle = new ScriptBundle(VIRTUAL_BUNDLE_PATH)
                .IncludeDirectory(ANGULAR_APP_ROOT, "*.js", searchSubdirectories: true);
            bundles.Add(scriptBundle);
            //bundles.Add(new StyleBundle("~/Content/css").Include(
            //    "~/Content/jquery-ui.min.css",
            //    "~/Content/style.css",
            //    "~/Content/paging.css",
            //    "~/Content/bootstrap.min.css",
            //    "~/Content/bootstrapValidator.min.css",
            //    "~/Content/bootstrap-multiselect.css",
            //    "~/Content/font-awesome.min.css",
            //    "~/Content/jquery.jqGrid/ui.jqgrid.css",
            //    "~/Content/jquery.jqGrid/ui.jqgrid.css"
            //    ));
            BundleTable.EnableOptimizations = true;
        }
    }
}