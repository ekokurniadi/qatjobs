import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart' as m;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qatjobs/core/helpers/date_helper.dart';
import 'package:qatjobs/core/helpers/dio_helper.dart';
import 'package:qatjobs/core/helpers/global_helper.dart';
import 'package:qatjobs/features/profile/candidate/data/models/cv_builder_models.codegen.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

class CvPdfGenerator {
  Future<Uint8List?> generate(
    CvBuilderResponseModels data,
    m.BuildContext parentcontext,
  ) async {
    var response = await DioHelper.dio!.get(
      data.candidate.user?.avatar ?? '',
      options: Options(responseType: ResponseType.bytes),
    );
    var img = response.data;

    final doc = Document(
      theme: ThemeData.withFont(
        icons: await PdfGoogleFonts.materialIcons(),
      ),
    );
    doc.addPage(
      Page(
        pageFormat: PdfPageFormat.undefined.copyWith(
          marginRight: 16,
          marginLeft: 16,
          marginTop: 0,
          marginBottom: 0,
          width: m.MediaQuery.of(parentcontext).size.width,
          height: m.MediaQuery.of(parentcontext).size.height,
        ),
        build: (Context context) {
          return Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: 16.h),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    '\t\tCurriculum Vitae\t\t',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22.sp,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                SizedBox(height: 32.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: PdfColors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: PdfColors.grey500,
                              ),
                            ),
                            child: ClipOval(
                              child: Image(
                                MemoryImage(img),
                                width: 60.w,
                                height: 60.w,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        data.candidate.user?.fullName ?? '',
                                        style: TextStyle(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(children: [
                                      Icon(
                                        const IconData(0xe0be),
                                        color: PdfColors.amber,
                                        size: 18.sp,
                                      ),
                                      SizedBox(width: 8.w),
                                      Text(
                                        data.candidate.user?.email ?? '',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ]),
                                    Row(children: [
                                      Icon(
                                        const IconData(0xe0cd),
                                        color: PdfColors.amber,
                                        size: 18.sp,
                                      ),
                                      SizedBox(width: 8.w),
                                      Text(
                                        data.candidate.user?.phone ?? '',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ]),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Skills',
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      if (data.candidateSkill.isNotEmpty)
                        Container(
                          width: double.infinity,
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.start,
                            alignment: WrapAlignment.start,
                            spacing: 4.w,
                            children: List.generate(
                              data.candidateSkill.length,
                              (index) {
                                return Container(
                                  width: 150.w,
                                  child: Row(
                                    children: [
                                      Icon(
                                        const IconData(0xef4a),
                                        color: PdfColors.amber,
                                        size: 12.sp,
                                      ),
                                      SizedBox(width: 8.w),
                                      Text(
                                        data.candidateSkill[index].name,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ).toList(),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Educations',
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      if (!GlobalHelper.isEmptyList(data.candidate.educations))
                        ListView(
                          children: List.generate(
                            data.candidate.educations!.length,
                            (index) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 8.h),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: 4.h,
                                        ),
                                        child: Icon(
                                          const IconData(0xef4a),
                                          color: PdfColors.amber,
                                          size: 12.sp,
                                        ),
                                      ),
                                      SizedBox(width: 8.w),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'Institute : ',
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                              Text(
                                                data
                                                    .candidate
                                                    .educations![index]
                                                    .institute,
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 4.w),
                                          Row(
                                            children: [
                                              Text(
                                                'Degree Level : ',
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                              Text(
                                                data
                                                        .candidate
                                                        .educations![index]
                                                        .degreeLevel
                                                        ?.name ??
                                                    '-',
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 4.w),
                                          Row(
                                            children: [
                                              Text(
                                                'Result : ',
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                              Text(
                                                data.candidate
                                                    .educations![index].result,
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 4.w),
                                          Row(
                                            children: [
                                              Text(
                                                'Year : ',
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                              Text(
                                                data.candidate
                                                    .educations![index].year
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Experiences',
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      if (!GlobalHelper.isEmptyList(data.candidate.experiences))
                        ListView(
                          children: List.generate(
                            data.candidate.experiences!.length,
                            (index) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 8.h),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: 4.h,
                                        ),
                                        child: Icon(
                                          const IconData(0xef4a),
                                          color: PdfColors.amber,
                                          size: 12.sp,
                                        ),
                                      ),
                                      SizedBox(width: 8.w),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data.candidate.experiences![index]
                                                .experienceTitle,
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 4.w),
                                          Text(
                                            data.candidate.experiences![index]
                                                .company,
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          SizedBox(height: 4.w),
                                          Row(
                                            children: [
                                              Text(
                                                DateHelper.formatdMy(data
                                                    .candidate
                                                    .experiences![index]
                                                    .startDate),
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                              Text(
                                                ' - ',
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                              Text(
                                                data
                                                        .candidate
                                                        .experiences![index]
                                                        .currentlyWorking
                                                    ? 'Present'
                                                    : DateHelper.formatdMy(
                                                        data
                                                            .candidate
                                                            .experiences![index]
                                                            .endDate,
                                                      ),
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Social Media',
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 4.h,
                                      ),
                                      child: Icon(
                                        IconData(FontAwesomeIcons
                                            .facebook.codePoint),
                                        color: PdfColors.amber,
                                        size: 16.sp,
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    Text(
                                      data.candidate.user?.facebookUrl ?? '-',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 4.h,
                                      ),
                                      child: Icon(
                                        IconData(FontAwesomeIcons
                                            .facebook.codePoint),
                                        color: PdfColors.amber,
                                        size: 16.sp,
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    Text(
                                      data.candidate.user?.linkedinUrl ?? '-',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Expanded(
                              child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 4.h,
                                    ),
                                    child: Icon(
                                      IconData(
                                          FontAwesomeIcons.facebook.codePoint),
                                      color: PdfColors.amber,
                                      size: 16.sp,
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    data.candidate.user?.pinterestUrl ?? '-',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 4.h,
                                    ),
                                    child: Icon(
                                      IconData(
                                          FontAwesomeIcons.facebook.codePoint),
                                      color: PdfColors.amber,
                                      size: 16.sp,
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    data.candidate.user?.googlePlusUrl ?? '-',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ); // Center
        },
      ),
    );
    return await doc.save();
  }
}
