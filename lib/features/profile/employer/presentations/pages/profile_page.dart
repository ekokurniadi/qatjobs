import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/resolution_style.dart';
import 'package:qatjobs/core/styles/text_name_style.dart';
import 'package:qatjobs/core/widget/custom_appbar_widget.dart';
import 'package:qatjobs/core/widget/custom_text_field.dart';
import 'package:qatjobs/core/widget/dropdown_search_widget.dart';
import 'package:qatjobs/core/widget/vertical_space_widget.dart';
import 'package:qatjobs/features/company/data/models/company_model.codegen.dart';
import 'package:qatjobs/features/employer_type/data/models/employer_type_model.codegen.dart';
import 'package:qatjobs/features/employer_type/presentations/bloc/employer_type_bloc.dart';
import 'package:qatjobs/features/industry/data/models/industry_model.codegen.dart';
import 'package:qatjobs/features/industry/presentations/bloc/industry_bloc.dart';
import 'package:qatjobs/features/profile/employer/presentations/cubit/employer_cubit.dart';
import 'package:qatjobs/features/users/data/models/users_model.codegen.dart';
import 'package:qatjobs/injector.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController facebookController = TextEditingController();
  final TextEditingController twitterController = TextEditingController();
  final TextEditingController linkedinController = TextEditingController();
  final TextEditingController googlePlusController = TextEditingController();
  final TextEditingController pinterestController = TextEditingController();
  final TextEditingController estController = TextEditingController();
  final TextEditingController ceoNameController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController location2Controller = TextEditingController();
  final TextEditingController noOfficeController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  final TextEditingController faxController = TextEditingController();
  final ValueNotifier<int> selectedEmployerType = ValueNotifier(0);
  final ValueNotifier<int> selectedIndustry = ValueNotifier(0);
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    context.read<EmployerCubit>().getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg300,
      appBar: const CustomAppBar(
        title: 'Profile',
        showLeading: true,
      ),
      body: BlocListener<EmployerCubit, EmployerState>(
        listener: (context, state) {
          if (state.status == EmployerStatus.getProfileSuccess) {
            nameController.text = state.companyModel.user?.firstName ?? '';
            emailController.text = state.companyModel.user?.email ?? '';
            phoneController.text = state.companyModel.user?.phone ?? '';
            facebookController.text =
                state.companyModel.user?.facebookUrl ?? '';
            twitterController.text = state.companyModel.user?.twitterUrl ?? '';
            linkedinController.text =
                state.companyModel.user?.linkedinUrl ?? '';
            googlePlusController.text =
                state.companyModel.user?.googlePlusUrl ?? '';
            pinterestController.text =
                state.companyModel.user?.pinterestUrl ?? '';
            estController.text =
                (state.companyModel.establishedIn ?? '0').toString();
            ceoNameController.text = state.companyModel.ceo ?? '';
            selectedIndustry.value = state.companyModel.industryId ?? 0;
            selectedEmployerType.value =
                state.companyModel.ownershipTypeId ?? 0;
            detailsController.text = 'details';
            // detailsController.text = state.companyModel.details ?? '';
            locationController.text = state.companyModel.location ?? '';
            location2Controller.text = state.companyModel.location2 ?? '';
            noOfficeController.text =
                (state.companyModel.noOfOffices ?? 0).toString();
            websiteController.text = state.companyModel.website ?? '';
            faxController.text = state.companyModel.fax ?? '';
            setState(() {});
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: defaultPadding,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    placeholder: 'Name',
                    isRequired: true,
                    label: 'Name',
                    controller: nameController,
                    isAlwaysShowLabel: true,
                  ),
                  CustomTextField(
                    placeholder: 'Email',
                    isRequired: true,
                    label: 'Email',
                    controller: emailController,
                    isAlwaysShowLabel: true,
                    isReadOnly: true,
                  ),
                  Container(
                    width: double.infinity,
                    padding: defaultPadding,
                    margin: EdgeInsets.only(bottom: 16.h),
                    decoration: BoxDecoration(
                      color: AppColors.bg200,
                      borderRadius: BorderRadius.circular(
                        8.r,
                      ),
                    ),
                    child: IntlPhoneField(
                      disableLengthCheck: true,
                      invalidNumberMessage: 'Invalid format',
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: phoneController,
                      dropdownIconPosition: IconPosition.leading,
                      validator: (val) {
                        if (val!.number.length < 9) {
                          return 'Invalid Phone Number, minimum length is 9 digits';
                        } else if (val.number.length > 9) {
                          return 'Invalid Phone Number, maximum length is 9 digits';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Phone',
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          label: IText.set(
                            text: 'Phone',
                            typeName: TextTypeName.headline3,
                            styleName: TextStyleName.regular,
                            color: AppColors.textPrimary,
                          )),
                      languageCode: "en",
                      initialCountryCode: 'QA',
                    ),
                  ),
                  CustomTextField(
                    placeholder: 'CEO Name',
                    isRequired: true,
                    label: 'CEO Name',
                    controller: ceoNameController,
                    isAlwaysShowLabel: true,
                  ),
                  BlocProvider(
                    create: (context) => getIt<IndustryBloc>()
                      ..add(
                        const IndustryEvent.started(),
                      ),
                    child: BlocBuilder<IndustryBloc, IndustryState>(
                      builder: (context, state) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 16.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: AppColors.bg200,
                          ),
                          child: DropdownSearchWidget<IndustryModel>(
                            alwaysShowLabel: true,
                            label: 'Industry',
                            items: state.types,
                            selectedItem: state.types.firstWhereOrNull(
                                (element) =>
                                    element.id == selectedIndustry.value),
                            itemAsString: (val) {
                              return val.name;
                            },
                            onChanged: (val) {
                              selectedIndustry.value = val?.id ?? 0;
                            },
                            hintText: 'Industry',
                          ),
                        );
                      },
                    ),
                  ),
                  BlocProvider(
                    create: (context) => getIt<EmployerTypeBloc>()
                      ..add(
                        const EmployerTypeEvent.started(),
                      ),
                    child: BlocBuilder<EmployerTypeBloc, EmployerTypeState>(
                      builder: (context, state) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 16.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: AppColors.bg200,
                          ),
                          child: DropdownSearchWidget<EmployerTypeModel>(
                            alwaysShowLabel: true,
                            label: 'Employer Type',
                            items: state.types,
                            selectedItem: state.types.firstWhereOrNull(
                                (element) =>
                                    element.id == selectedEmployerType.value),
                            itemAsString: (val) {
                              return val.name;
                            },
                            onChanged: (val) {
                              selectedEmployerType.value = val?.id ?? 0;
                            },
                            hintText: 'Employer Type',
                          ),
                        );
                      },
                    ),
                  ),
                  CustomTextField(
                    placeholder: 'Established in',
                    label: 'Established in',
                    isAlwaysShowLabel: true,
                    isRequired: true,
                    textInputType: TextInputType.number,
                    controller: estController,
                  ),
                  CustomTextField(
                    placeholder: 'Employer Details',
                    label: 'Employer Details',
                    isAlwaysShowLabel: true,
                    isRequired: true,
                    controller: detailsController,
                  ),
                  CustomTextField(
                    placeholder: 'Location',
                    label: 'Location',
                    isAlwaysShowLabel: true,
                    isRequired: true,
                    controller: locationController,
                  ),
                  CustomTextField(
                    placeholder: '2nd Office Location',
                    label: '2nd Office Location',
                    isAlwaysShowLabel: true,
                    controller: location2Controller,
                  ),
                  CustomTextField(
                    placeholder: 'No of Office',
                    label: 'No of Office',
                    isAlwaysShowLabel: true,
                    isRequired: true,
                    controller: noOfficeController,
                  ),
                  CustomTextField(
                    placeholder: 'Website',
                    label: 'Website',
                    isAlwaysShowLabel: true,
                    controller: websiteController,
                  ),
                  CustomTextField(
                    placeholder: 'Fax',
                    label: 'Fax',
                    isAlwaysShowLabel: true,
                    controller: faxController,
                  ),
                  CustomTextField(
                    placeholder: 'Facebook URL',
                    label: 'Facebook URL',
                    isAlwaysShowLabel: true,
                    controller: facebookController,
                  ),
                  CustomTextField(
                    placeholder: 'Twitter URL',
                    label: 'Twitter URL',
                    isAlwaysShowLabel: true,
                    controller: twitterController,
                  ),
                  CustomTextField(
                    placeholder: 'Linkedin URL',
                    label: 'Linkedin URL',
                    isAlwaysShowLabel: true,
                    controller: linkedinController,
                  ),
                  CustomTextField(
                    placeholder: 'Pinterest URL',
                    label: 'Pinterest URL',
                    isAlwaysShowLabel: true,
                    controller: pinterestController,
                  ),
                  CustomTextField(
                    placeholder: 'Google+ URL',
                    label: 'Google+ URL',
                    isAlwaysShowLabel: true,
                    controller: googlePlusController,
                  ),
                  SpaceWidget(space: 84.h),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.bg200,
          boxShadow: AppColors.defaultShadow,
        ),
        child: BlocBuilder<EmployerCubit, EmployerState>(
          builder: (context, state) {
            return Container(
              width: double.infinity,
              height: 50.h,
              margin: defaultPadding,
              child: ElevatedButton(
                onPressed: () {
                  if (!_formKey.currentState!.validate()) return;
                  context.read<EmployerCubit>().updateProfileCompany(
                        CompanyModel(
                          ceo: ceoNameController.text,
                          details: detailsController.text,
                          establishedIn: int.tryParse(estController.text) ?? 0,
                          fax: faxController.text,
                          industryId: selectedIndustry.value,
                          ownershipTypeId: selectedEmployerType.value,
                          location: locationController.text,
                          location2: location2Controller.text,
                          website: websiteController.text,
                          noOfOffices:
                              int.tryParse(noOfficeController.text) ?? 0,
                          userId: state.companyModel.userId,
                          user: UserModel(
                            id: state.companyModel.userId ?? 0,
                            firstName: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                            facebookUrl: facebookController.text,
                            twitterUrl: twitterController.text,
                            linkedinUrl: linkedinController.text,
                            googlePlusUrl: googlePlusController.text,
                            pinterestUrl: pinterestController.text,
                          ),
                        ),
                      );
                },
                child: const Text('Save'),
              ),
            );
          },
        ),
      ),
    );
  }
}
