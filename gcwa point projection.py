import arcpy # import arcpy  
import math # import math  
fc = r'XYlocales.shp' # change to your existing input feature class  
new_fc = r'blank.shp' # change to your existing output feature class  
fields = ['xcoord', 'ycoord', 'distance','bearing'] # existing fields in input  
outFields = ['SHAPE@','x', 'y', 'distance','bearing'] # existing fields in output  
iCursor = arcpy.da.InsertCursor(new_fc,outFields ) # insert cursor  
with arcpy.da.SearchCursor(fc, fields) as sCursor: # search cursor  
    for row in sCursor: # loop through rows in search cursor  
        inputX = row[0] # 1st field in search cursor  
        inputY = row[1] # 2nd field in search cursor  
        distance = row[2] # 3rd field in search cursor  
        bearing = row[3] # 4th field in search cursor  
        bearing = math.radians(float(bearing)) # convert to radians  
        newX = inputX + distance * math.sin(bearing) # calc new X  
        newY = inputY + distance * math.cos(bearing) # calc new Y  
        point = arcpy.Point(newX,newY) # create new point  
        temp = [point,newX,newY,distance,bearing] # organize new attributes  
        iCursor.insertRow(temp) # write new row  
del iCursor # delete insert cursor  
