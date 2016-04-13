defineClass("JPTableViewController",{ 
   tableView_didSelectRowAtIndexPath:funtion(tableView, indexPath){
       var row = indexPath.row()
       if(self.dataSource().length > row){
           var content = self.dataSource()[row];
           var controller = JPViewController.alloc().initWithContent(content);
           self.navagationController().pushViewController(controller);
        }
   }
})
