#import "DbAccess.h"

@implementation DbAccess
sqlite3* DB;
NSString* dbFullPath;
static DbAccess * dbAc = nil;

-(id)initWithPath:(NSString *)path dbCreator:(DbTableCreator *)creator{
    
    self = [super init];
    if(self){
        self.dbSourcePath = path;
        self.dbCreator = creator;
    }
    return self;
}

-(void)loaddb{
    NSString *docsDir;
    
    //get the app path for db
    docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    
    //join path with db name
    dbFullPath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: self.dbSourcePath]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    //If the files doesn't exist then...
    if (![filemgr fileExistsAtPath: dbFullPath]) {
        const char *dbpath = [dbFullPath UTF8String];
        sqlite3_open(dbpath, &DB);
        char* error;
        //Loop through all our table creatorst
        for(NSString* item in self.dbCreator.dbCreators)
        {
            //Create new table
            const char* sqlTableCreatorutf16 = [item UTF8String];
            sqlite3_exec(DB, sqlTableCreatorutf16, NULL, NULL, &error);
        }
        sqlite3_close(DB);
    }
    
}

-(void)executeStatement:(NSString *)query{
    const char *dbpath = [dbFullPath UTF8String];
    sqlite3_stmt  *statement;
    
    if(sqlite3_open(dbpath, &DB) == SQLITE_OK)
    {
        //Execute the insert
        const char * utf16v = [query UTF8String];
        sqlite3_prepare_v2(DB, utf16v, -1, &statement, NULL);
        
        sqlite3_step(statement);
        
        sqlite3_finalize(statement);
        sqlite3_close(DB);
    }
}

-(void)selectStatement:(NSString *)query itempulledBack:(void (^)(id))val{
    const char *dbpath = [dbFullPath UTF8String];
    sqlite3_stmt  *statement;
    
    if(sqlite3_open(dbpath, &DB) == SQLITE_OK)
    {
        NSMutableDictionary *currentRow;
        const char * utf16v = [query UTF8String];
        int resultOfPrepare = sqlite3_prepare_v2(DB, utf16v, -1, &statement, NULL);
        
        if(resultOfPrepare == SQLITE_OK)
        {
            //Loop through each row returned
            while(sqlite3_step(statement) == SQLITE_ROW){
                currentRow = [[NSMutableDictionary alloc]init];
                
                int cols = sqlite3_column_count(statement);
                
                //Loop each column in the row
                for(int i = 0; i < cols; i ++){
                    char *dbDataAsChars = (char *)sqlite3_column_text(statement, i);
                    char* colHeader = (char*)sqlite3_column_name(statement, i);
                    if(dbDataAsChars != NULL){
                        [currentRow setObject:[NSString stringWithUTF8String:dbDataAsChars] forKey:[NSString stringWithUTF8String:colHeader]];
                    }
                }
                val(currentRow); //Use block to pass data back to caller.
                currentRow = nil;
            }
        }
        sqlite3_finalize(statement);
    }
    
    sqlite3_close(DB);
}


+ (DbAccess*) instance{
    //Lazy load, only create the dbaccess when we first need it
    if(dbAc == nil){
        DbTableCreator* creator = [[DbTableCreator alloc]initDbCreator];
        [creator addDbStr:FAVE_PLACES_TABLE];
        [creator addDbStr:IMAGE_LINK_TABLE];
        [creator addDbStr:HIGHSCORES_TABLE];
        dbAc = [[DbAccess alloc]initWithPath:@"miCity.db" dbCreator:creator];
        
        [dbAc loaddb];
    }
    
    return dbAc;
    
}
@end
