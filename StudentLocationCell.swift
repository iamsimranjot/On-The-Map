//
//  StudentLocationCell.swift
//  On The Map
//
//  Created by Simranjot Singh on 10/01/17.
//  Copyright © 2017 SimranJot Singh. All rights reserved.
//

import UIKit

class StudentLocationCell: UITableViewCell {

    //MARK: Outlets
    
    @IBOutlet weak var pinImage: UIImageView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var mediaURL: UILabel!
    
    func configureStudentLocationCell(studentLocation: StudentLocationModel){
        pinImage.image = #imageLiteral(resourceName: "pin")
        fullName.text = studentLocation.student.fullName
        mediaURL.text = studentLocation.student.mediaURL
    }

}
