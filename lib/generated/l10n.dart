// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Sign in`
  String get sign_in {
    return Intl.message(
      'Sign in',
      name: 'sign_in',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get sign_up {
    return Intl.message(
      'Sign up',
      name: 'sign_up',
      desc: '',
      args: [],
    );
  }

  /// `Login Success`
  String get login_success {
    return Intl.message(
      'Login Success',
      name: 'login_success',
      desc: '',
      args: [],
    );
  }

  /// `Let's start`
  String get register_start {
    return Intl.message(
      'Let\'s start',
      name: 'register_start',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Display Name`
  String get display_name {
    return Intl.message(
      'Display Name',
      name: 'display_name',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message(
      'Gender',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get gender_male {
    return Intl.message(
      'Male',
      name: 'gender_male',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get gender_female {
    return Intl.message(
      'Female',
      name: 'gender_female',
      desc: '',
      args: [],
    );
  }

  /// `Age`
  String get age {
    return Intl.message(
      'Age',
      name: 'age',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match.`
  String get password_mismatch {
    return Intl.message(
      'Passwords do not match.',
      name: 'password_mismatch',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get create_account {
    return Intl.message(
      'Create Account',
      name: 'create_account',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirm_password {
    return Intl.message(
      'Confirm Password',
      name: 'confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Or create account with`
  String get or_create_account_with {
    return Intl.message(
      'Or create account with',
      name: 'or_create_account_with',
      desc: '',
      args: [],
    );
  }

  /// `Welcome back`
  String get welcome_back {
    return Intl.message(
      'Welcome back',
      name: 'welcome_back',
      desc: '',
      args: [],
    );
  }

  /// `Load Notifications`
  String get loadNotifications {
    return Intl.message(
      'Load Notifications',
      name: 'loadNotifications',
      desc: '',
      args: [],
    );
  }

  /// `No Notifications`
  String get noNotifications {
    return Intl.message(
      'No Notifications',
      name: 'noNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgot_password {
    return Intl.message(
      'Forgot Password?',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get no_account {
    return Intl.message(
      'Don\'t have an account?',
      name: 'no_account',
      desc: '',
      args: [],
    );
  }

  /// `Create one`
  String get create_one {
    return Intl.message(
      'Create one',
      name: 'create_one',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password!`
  String get forgot_password_title {
    return Intl.message(
      'Forgot Password!',
      name: 'forgot_password_title',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email to get the code`
  String get enter_email_to_get_code {
    return Intl.message(
      'Enter your email to get the code',
      name: 'enter_email_to_get_code',
      desc: '',
      args: [],
    );
  }

  /// `Enter Email`
  String get enter_email {
    return Intl.message(
      'Enter Email',
      name: 'enter_email',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `Code sent successfully`
  String get code_sent_success {
    return Intl.message(
      'Code sent successfully',
      name: 'code_sent_success',
      desc: '',
      args: [],
    );
  }

  /// `Enter the code sent to your email`
  String get enter_received_code {
    return Intl.message(
      'Enter the code sent to your email',
      name: 'enter_received_code',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Enter your new password to log in`
  String get new_password_instruction {
    return Intl.message(
      'Enter your new password to log in',
      name: 'new_password_instruction',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwords_do_not_match {
    return Intl.message(
      'Passwords do not match',
      name: 'passwords_do_not_match',
      desc: '',
      args: [],
    );
  }

  /// `Password changed successfully`
  String get password_changed_success {
    return Intl.message(
      'Password changed successfully',
      name: 'password_changed_success',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Account created successfully`
  String get account_created_successfully {
    return Intl.message(
      'Account created successfully',
      name: 'account_created_successfully',
      desc: '',
      args: [],
    );
  }

  /// `This field is required`
  String get this_field_is_required {
    return Intl.message(
      'This field is required',
      name: 'this_field_is_required',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email`
  String get enter_valid_email {
    return Intl.message(
      'Please enter a valid email',
      name: 'enter_valid_email',
      desc: '',
      args: [],
    );
  }

  /// `Invalid code`
  String get invalid_code {
    return Intl.message(
      'Invalid code',
      name: 'invalid_code',
      desc: '',
      args: [],
    );
  }

  /// `Didn't receive code?`
  String get didnt_receive_code {
    return Intl.message(
      'Didn\'t receive code?',
      name: 'didnt_receive_code',
      desc: '',
      args: [],
    );
  }

  /// `Resend`
  String get resend {
    return Intl.message(
      'Resend',
      name: 'resend',
      desc: '',
      args: [],
    );
  }

  /// `Available tests can determine your anxiety and depression levels to check if you need professional help to overcome your nightmares and return to your life without any disturbances`
  String get test_description {
    return Intl.message(
      'Available tests can determine your anxiety and depression levels to check if you need professional help to overcome your nightmares and return to your life without any disturbances',
      name: 'test_description',
      desc: '',
      args: [],
    );
  }

  /// `Start Test`
  String get start_test {
    return Intl.message(
      'Start Test',
      name: 'start_test',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Let's start`
  String get lets_start {
    return Intl.message(
      'Let\'s start',
      name: 'lets_start',
      desc: '',
      args: [],
    );
  }

  /// `Tests names fetched successfully`
  String get tests_fetched_success {
    return Intl.message(
      'Tests names fetched successfully',
      name: 'tests_fetched_success',
      desc: '',
      args: [],
    );
  }

  /// `Previous`
  String get previous {
    return Intl.message(
      'Previous',
      name: 'previous',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Which test would you like to take?`
  String get which_test_to_take {
    return Intl.message(
      'Which test would you like to take?',
      name: 'which_test_to_take',
      desc: '',
      args: [],
    );
  }

  /// `Please select a test`
  String get please_select_test {
    return Intl.message(
      'Please select a test',
      name: 'please_select_test',
      desc: '',
      args: [],
    );
  }

  /// `Invalid test selected`
  String get invalid_test_selected {
    return Intl.message(
      'Invalid test selected',
      name: 'invalid_test_selected',
      desc: '',
      args: [],
    );
  }

  /// `Select a test`
  String get select_test {
    return Intl.message(
      'Select a test',
      name: 'select_test',
      desc: '',
      args: [],
    );
  }

  /// `Learn about the test`
  String get learn_about_test {
    return Intl.message(
      'Learn about the test',
      name: 'learn_about_test',
      desc: '',
      args: [],
    );
  }

  /// `Data loaded successfully`
  String get data_loaded_successfully {
    return Intl.message(
      'Data loaded successfully',
      name: 'data_loaded_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Please wait...`
  String get please_wait {
    return Intl.message(
      'Please wait...',
      name: 'please_wait',
      desc: '',
      args: [],
    );
  }

  /// `Month`
  String get month {
    return Intl.message(
      'Month',
      name: 'month',
      desc: '',
      args: [],
    );
  }

  /// `Week`
  String get week {
    return Intl.message(
      'Week',
      name: 'week',
      desc: '',
      args: [],
    );
  }

  /// `Notes`
  String get notes {
    return Intl.message(
      'Notes',
      name: 'notes',
      desc: '',
      args: [],
    );
  }

  /// `Chart`
  String get chart {
    return Intl.message(
      'Chart',
      name: 'chart',
      desc: '',
      args: [],
    );
  }

  /// `No data available`
  String get no_data_available {
    return Intl.message(
      'No data available',
      name: 'no_data_available',
      desc: '',
      args: [],
    );
  }

  /// `How is your mood today?`
  String get how_is_your_mood_today {
    return Intl.message(
      'How is your mood today?',
      name: 'how_is_your_mood_today',
      desc: '',
      args: [],
    );
  }

  /// `What happened to you today?`
  String get what_happened_to_you_today {
    return Intl.message(
      'What happened to you today?',
      name: 'what_happened_to_you_today',
      desc: '',
      args: [],
    );
  }

  /// `Enter today's notes`
  String get enter_todays_notes {
    return Intl.message(
      'Enter today\'s notes',
      name: 'enter_todays_notes',
      desc: '',
      args: [],
    );
  }

  /// `How do you feel today?`
  String get how_do_you_feel_today {
    return Intl.message(
      'How do you feel today?',
      name: 'how_do_you_feel_today',
      desc: '',
      args: [],
    );
  }

  /// `Enter your answer`
  String get enter_your_answer {
    return Intl.message(
      'Enter your answer',
      name: 'enter_your_answer',
      desc: '',
      args: [],
    );
  }

  /// `Mon`
  String get mon {
    return Intl.message(
      'Mon',
      name: 'mon',
      desc: '',
      args: [],
    );
  }

  /// `Tue`
  String get tue {
    return Intl.message(
      'Tue',
      name: 'tue',
      desc: '',
      args: [],
    );
  }

  /// `Wed`
  String get wed {
    return Intl.message(
      'Wed',
      name: 'wed',
      desc: '',
      args: [],
    );
  }

  /// `Thu`
  String get thu {
    return Intl.message(
      'Thu',
      name: 'thu',
      desc: '',
      args: [],
    );
  }

  /// `Fri`
  String get fri {
    return Intl.message(
      'Fri',
      name: 'fri',
      desc: '',
      args: [],
    );
  }

  /// `Sat`
  String get sat {
    return Intl.message(
      'Sat',
      name: 'sat',
      desc: '',
      args: [],
    );
  }

  /// `Sun`
  String get sun {
    return Intl.message(
      'Sun',
      name: 'sun',
      desc: '',
      args: [],
    );
  }

  /// `Mood: `
  String get mood {
    return Intl.message(
      'Mood: ',
      name: 'mood',
      desc: '',
      args: [],
    );
  }

  /// `Feeling: `
  String get feeling {
    return Intl.message(
      'Feeling: ',
      name: 'feeling',
      desc: '',
      args: [],
    );
  }

  /// `Notes: `
  String get notes_label {
    return Intl.message(
      'Notes: ',
      name: 'notes_label',
      desc: '',
      args: [],
    );
  }

  /// `No feeling recorded`
  String get no_feeling_recorded {
    return Intl.message(
      'No feeling recorded',
      name: 'no_feeling_recorded',
      desc: '',
      args: [],
    );
  }

  /// `No notes recorded`
  String get no_notes_recorded {
    return Intl.message(
      'No notes recorded',
      name: 'no_notes_recorded',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Select your mood today and track its progress throughout the month`
  String get track_mood_description {
    return Intl.message(
      'Select your mood today and track its progress throughout the month',
      name: 'track_mood_description',
      desc: '',
      args: [],
    );
  }

  /// `Tests`
  String get tests {
    return Intl.message(
      'Tests',
      name: 'tests',
      desc: '',
      args: [],
    );
  }

  /// `Chatbot`
  String get chatbot {
    return Intl.message(
      'Chatbot',
      name: 'chatbot',
      desc: '',
      args: [],
    );
  }

  /// `Blog`
  String get blog {
    return Intl.message(
      'Blog',
      name: 'blog',
      desc: '',
      args: [],
    );
  }

  /// `Community`
  String get community {
    return Intl.message(
      'Community',
      name: 'community',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Habits`
  String get habits {
    return Intl.message(
      'Habits',
      name: 'habits',
      desc: '',
      args: [],
    );
  }

  /// `Mood Status`
  String get mood_label {
    return Intl.message(
      'Mood Status',
      name: 'mood_label',
      desc: '',
      args: [],
    );
  }

  /// `Allows the user to track and record their thoughts, feelings, and mental state`
  String get first_page_description {
    return Intl.message(
      'Allows the user to track and record their thoughts, feelings, and mental state',
      name: 'first_page_description',
      desc: '',
      args: [],
    );
  }

  /// `To monitor the user's mood daily to control its progress towards improvement`
  String get second_page_description {
    return Intl.message(
      'To monitor the user\'s mood daily to control its progress towards improvement',
      name: 'second_page_description',
      desc: '',
      args: [],
    );
  }

  /// `Includes some questions to help you determine your state`
  String get third_page_description {
    return Intl.message(
      'Includes some questions to help you determine your state',
      name: 'third_page_description',
      desc: '',
      args: [],
    );
  }

  /// `To improve your mood with videos, books, audio clips, and healthy habits to help you gain a better routine every day`
  String get fourth_page_description {
    return Intl.message(
      'To improve your mood with videos, books, audio clips, and healthy habits to help you gain a better routine every day',
      name: 'fourth_page_description',
      desc: '',
      args: [],
    );
  }

  /// `Chatbot`
  String get first_page_title {
    return Intl.message(
      'Chatbot',
      name: 'first_page_title',
      desc: '',
      args: [],
    );
  }

  /// `Calendar`
  String get second_page_title {
    return Intl.message(
      'Calendar',
      name: 'second_page_title',
      desc: '',
      args: [],
    );
  }

  /// `Tests`
  String get third_page_title {
    return Intl.message(
      'Tests',
      name: 'third_page_title',
      desc: '',
      args: [],
    );
  }

  /// `Content`
  String get fourth_page_title {
    return Intl.message(
      'Content',
      name: 'fourth_page_title',
      desc: '',
      args: [],
    );
  }

  /// `Test Result`
  String get test_result {
    return Intl.message(
      'Test Result',
      name: 'test_result',
      desc: '',
      args: [],
    );
  }

  /// `Your Score`
  String get your_score {
    return Intl.message(
      'Your Score',
      name: 'your_score',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Error fetching questions`
  String get questions_error {
    return Intl.message(
      'Error fetching questions',
      name: 'questions_error',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while fetching questions`
  String get error_fetching_questions {
    return Intl.message(
      'An error occurred while fetching questions',
      name: 'error_fetching_questions',
      desc: '',
      args: [],
    );
  }

  /// `No questions available`
  String get no_questions_available {
    return Intl.message(
      'No questions available',
      name: 'no_questions_available',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Mood Tracker`
  String get mood_tracker_title {
    return Intl.message(
      'Mood Tracker',
      name: 'mood_tracker_title',
      desc: '',
      args: [],
    );
  }

  /// `Error: Invalid chat data`
  String get invalid_chat_data {
    return Intl.message(
      'Error: Invalid chat data',
      name: 'invalid_chat_data',
      desc: '',
      args: [],
    );
  }

  /// `No old messages`
  String get no_old_messages {
    return Intl.message(
      'No old messages',
      name: 'no_old_messages',
      desc: '',
      args: [],
    );
  }

  /// `Error fetching messages`
  String get error_fetching_messages {
    return Intl.message(
      'Error fetching messages',
      name: 'error_fetching_messages',
      desc: '',
      args: [],
    );
  }

  /// `No messages`
  String get no_messages {
    return Intl.message(
      'No messages',
      name: 'no_messages',
      desc: '',
      args: [],
    );
  }

  /// `Try again`
  String get try_again {
    return Intl.message(
      'Try again',
      name: 'try_again',
      desc: '',
      args: [],
    );
  }

  /// `No available chats`
  String get no_available_chats {
    return Intl.message(
      'No available chats',
      name: 'no_available_chats',
      desc: '',
      args: [],
    );
  }

  /// `Create New Chat`
  String get create_new_chat {
    return Intl.message(
      'Create New Chat',
      name: 'create_new_chat',
      desc: '',
      args: [],
    );
  }

  /// `Chat {0}`
  String get chat_number {
    return Intl.message(
      'Chat {0}',
      name: 'chat_number',
      desc: '',
      args: [],
    );
  }

  /// `Delete Chat`
  String get delete_chat {
    return Intl.message(
      'Delete Chat',
      name: 'delete_chat',
      desc: '',
      args: [],
    );
  }

  /// `Write your message here...`
  String get write_message {
    return Intl.message(
      'Write your message here...',
      name: 'write_message',
      desc: '',
      args: [],
    );
  }

  /// `Chat {0}`
  String get chat_skeleton {
    return Intl.message(
      'Chat {0}',
      name: 'chat_skeleton',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get unknown {
    return Intl.message(
      'Unknown',
      name: 'unknown',
      desc: '',
      args: [],
    );
  }

  /// `Article`
  String get article {
    return Intl.message(
      'Article',
      name: 'article',
      desc: '',
      args: [],
    );
  }

  /// `Refresh`
  String get refresh {
    return Intl.message(
      'Refresh',
      name: 'refresh',
      desc: '',
      args: [],
    );
  }

  /// `No data currently`
  String get no_data_currently {
    return Intl.message(
      'No data currently',
      name: 'no_data_currently',
      desc: '',
      args: [],
    );
  }

  /// `Read more`
  String get read_more {
    return Intl.message(
      'Read more',
      name: 'read_more',
      desc: '',
      args: [],
    );
  }

  /// `Dummy Title`
  String get dummy_title {
    return Intl.message(
      'Dummy Title',
      name: 'dummy_title',
      desc: '',
      args: [],
    );
  }

  /// `Dummy Author`
  String get dummy_author {
    return Intl.message(
      'Dummy Author',
      name: 'dummy_author',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load user data, please ensure you are logged in`
  String get user_data_load_error {
    return Intl.message(
      'Failed to load user data, please ensure you are logged in',
      name: 'user_data_load_error',
      desc: '',
      args: [],
    );
  }

  /// `What's on your mind?`
  String get what_on_your_mind {
    return Intl.message(
      'What\'s on your mind?',
      name: 'what_on_your_mind',
      desc: '',
      args: [],
    );
  }

  /// `Invalid file link`
  String get invalid_file_link {
    return Intl.message(
      'Invalid file link',
      name: 'invalid_file_link',
      desc: '',
      args: [],
    );
  }

  /// `File`
  String get file {
    return Intl.message(
      'File',
      name: 'file',
      desc: '',
      args: [],
    );
  }

  /// `View more`
  String get view_more {
    return Intl.message(
      'View more',
      name: 'view_more',
      desc: '',
      args: [],
    );
  }

  /// `Like`
  String get like {
    return Intl.message(
      'Like',
      name: 'like',
      desc: '',
      args: [],
    );
  }

  /// `Comment`
  String get comment {
    return Intl.message(
      'Comment',
      name: 'comment',
      desc: '',
      args: [],
    );
  }

  /// `Write your comment...`
  String get write_comment_hint {
    return Intl.message(
      'Write your comment...',
      name: 'write_comment_hint',
      desc: '',
      args: [],
    );
  }

  /// `Edit your post...`
  String get edit_post_hint {
    return Intl.message(
      'Edit your post...',
      name: 'edit_post_hint',
      desc: '',
      args: [],
    );
  }

  /// `Edit your comment...`
  String get edit_comment_hint {
    return Intl.message(
      'Edit your comment...',
      name: 'edit_comment_hint',
      desc: '',
      args: [],
    );
  }

  /// `Image Preview`
  String get image_preview {
    return Intl.message(
      'Image Preview',
      name: 'image_preview',
      desc: '',
      args: [],
    );
  }

  /// `File Preview`
  String get file_preview {
    return Intl.message(
      'File Preview',
      name: 'file_preview',
      desc: '',
      args: [],
    );
  }

  /// `Create Post`
  String get create_post {
    return Intl.message(
      'Create Post',
      name: 'create_post',
      desc: '',
      args: [],
    );
  }

  /// `Image selected`
  String get image_selected {
    return Intl.message(
      'Image selected',
      name: 'image_selected',
      desc: '',
      args: [],
    );
  }

  /// `Image selection canceled`
  String get image_selection_canceled {
    return Intl.message(
      'Image selection canceled',
      name: 'image_selection_canceled',
      desc: '',
      args: [],
    );
  }

  /// `File selected`
  String get file_selected {
    return Intl.message(
      'File selected',
      name: 'file_selected',
      desc: '',
      args: [],
    );
  }

  /// `File selection canceled`
  String get file_selection_canceled {
    return Intl.message(
      'File selection canceled',
      name: 'file_selection_canceled',
      desc: '',
      args: [],
    );
  }

  /// `Photo`
  String get photo {
    return Intl.message(
      'Photo',
      name: 'photo',
      desc: '',
      args: [],
    );
  }

  /// `Poll`
  String get poll {
    return Intl.message(
      'Poll',
      name: 'poll',
      desc: '',
      args: [],
    );
  }

  /// `Audio`
  String get audio {
    return Intl.message(
      'Audio',
      name: 'audio',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message(
      'Camera',
      name: 'camera',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get location {
    return Intl.message(
      'Location',
      name: 'location',
      desc: '',
      args: [],
    );
  }

  /// `Attachment`
  String get attachment {
    return Intl.message(
      'Attachment',
      name: 'attachment',
      desc: '',
      args: [],
    );
  }

  /// `Selected`
  String get selected {
    return Intl.message(
      'Selected',
      name: 'selected',
      desc: '',
      args: [],
    );
  }

  /// `Enter option`
  String get enter_option {
    return Intl.message(
      'Enter option',
      name: 'enter_option',
      desc: '',
      args: [],
    );
  }

  /// `Posting...`
  String get posting {
    return Intl.message(
      'Posting...',
      name: 'posting',
      desc: '',
      args: [],
    );
  }

  /// `Post`
  String get post {
    return Intl.message(
      'Post',
      name: 'post',
      desc: '',
      args: [],
    );
  }

  /// `Please enter some content`
  String get please_enter_content {
    return Intl.message(
      'Please enter some content',
      name: 'please_enter_content',
      desc: '',
      args: [],
    );
  }

  /// `No data`
  String get no_data {
    return Intl.message(
      'No data',
      name: 'no_data',
      desc: '',
      args: [],
    );
  }

  /// `Add Option`
  String get add_option {
    return Intl.message(
      'Add Option',
      name: 'add_option',
      desc: '',
      args: [],
    );
  }

  /// `No comments`
  String get no_comments {
    return Intl.message(
      'No comments',
      name: 'no_comments',
      desc: '',
      args: [],
    );
  }

  /// `PDF File`
  String get pdf_file {
    return Intl.message(
      'PDF File',
      name: 'pdf_file',
      desc: '',
      args: [],
    );
  }

  /// `Show less`
  String get show_less {
    return Intl.message(
      'Show less',
      name: 'show_less',
      desc: '',
      args: [],
    );
  }

  /// `Show more`
  String get show_more {
    return Intl.message(
      'Show more',
      name: 'show_more',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load image, please try again later`
  String get image_load_error {
    return Intl.message(
      'Failed to load image, please try again later',
      name: 'image_load_error',
      desc: '',
      args: [],
    );
  }

  /// `Podcasts`
  String get podcasts {
    return Intl.message(
      'Podcasts',
      name: 'podcasts',
      desc: '',
      args: [],
    );
  }

  /// `Podcast Details`
  String get podcast_details {
    return Intl.message(
      'Podcast Details',
      name: 'podcast_details',
      desc: '',
      args: [],
    );
  }

  /// `Podcast`
  String get podcast {
    return Intl.message(
      'Podcast',
      name: 'podcast',
      desc: '',
      args: [],
    );
  }

  /// `No image`
  String get no_image {
    return Intl.message(
      'No image',
      name: 'no_image',
      desc: '',
      args: [],
    );
  }

  /// `Could not play audio`
  String get could_not_play_audio {
    return Intl.message(
      'Could not play audio',
      name: 'could_not_play_audio',
      desc: '',
      args: [],
    );
  }

  /// `Like added successfully`
  String get like_added_success {
    return Intl.message(
      'Like added successfully',
      name: 'like_added_success',
      desc: '',
      args: [],
    );
  }

  /// `Like removed successfully`
  String get like_removed_success {
    return Intl.message(
      'Like removed successfully',
      name: 'like_removed_success',
      desc: '',
      args: [],
    );
  }

  /// `What did you accomplish today?`
  String get what_did_you_accomplish_today {
    return Intl.message(
      'What did you accomplish today?',
      name: 'what_did_you_accomplish_today',
      desc: '',
      args: [],
    );
  }

  /// `Good job! Keep going and don’t slack off, you’ll reach a better result tomorrow`
  String get good_job_keep_going {
    return Intl.message(
      'Good job! Keep going and don’t slack off, you’ll reach a better result tomorrow',
      name: 'good_job_keep_going',
      desc: '',
      args: [],
    );
  }

  /// `Yoga and Breathing Exercises`
  String get yoga_and_breathing_exercises {
    return Intl.message(
      'Yoga and Breathing Exercises',
      name: 'yoga_and_breathing_exercises',
      desc: '',
      args: [],
    );
  }

  /// `Outdoor Walking`
  String get outdoor_walking {
    return Intl.message(
      'Outdoor Walking',
      name: 'outdoor_walking',
      desc: '',
      args: [],
    );
  }

  /// `Reading and Relaxation`
  String get reading_and_relaxation {
    return Intl.message(
      'Reading and Relaxation',
      name: 'reading_and_relaxation',
      desc: '',
      args: [],
    );
  }

  /// `Let's build healthy habits together and add them to your daily routine`
  String get lets_build_healthy_habits {
    return Intl.message(
      'Let\'s build healthy habits together and add them to your daily routine',
      name: 'lets_build_healthy_habits',
      desc: '',
      args: [],
    );
  }

  /// `Let's see how you spend your day with some relaxation`
  String get lets_relax_together {
    return Intl.message(
      'Let\'s see how you spend your day with some relaxation',
      name: 'lets_relax_together',
      desc: '',
      args: [],
    );
  }

  /// `Stop Watch`
  String get stop_watch {
    return Intl.message(
      'Stop Watch',
      name: 'stop_watch',
      desc: '',
      args: [],
    );
  }

  /// `Set Timer`
  String get set_timer {
    return Intl.message(
      'Set Timer',
      name: 'set_timer',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get start {
    return Intl.message(
      'Start',
      name: 'start',
      desc: '',
      args: [],
    );
  }

  /// `Pause`
  String get pause {
    return Intl.message(
      'Pause',
      name: 'pause',
      desc: '',
      args: [],
    );
  }

  /// `Resume`
  String get resume {
    return Intl.message(
      'Resume',
      name: 'resume',
      desc: '',
      args: [],
    );
  }

  /// `Reset`
  String get reset {
    return Intl.message(
      'Reset',
      name: 'reset',
      desc: '',
      args: [],
    );
  }

  /// `Timer`
  String get timer {
    return Intl.message(
      'Timer',
      name: 'timer',
      desc: '',
      args: [],
    );
  }

  /// `Hours`
  String get hours {
    return Intl.message(
      'Hours',
      name: 'hours',
      desc: '',
      args: [],
    );
  }

  /// `Minutes`
  String get minutes {
    return Intl.message(
      'Minutes',
      name: 'minutes',
      desc: '',
      args: [],
    );
  }

  /// `Seconds`
  String get seconds {
    return Intl.message(
      'Seconds',
      name: 'seconds',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid duration`
  String get invalid_time {
    return Intl.message(
      'Please enter a valid duration',
      name: 'invalid_time',
      desc: '',
      args: [],
    );
  }

  /// `What did you achieve today?`
  String get what_did_you_achieve_today {
    return Intl.message(
      'What did you achieve today?',
      name: 'what_did_you_achieve_today',
      desc: '',
      args: [],
    );
  }

  /// `Result`
  String get result {
    return Intl.message(
      'Result',
      name: 'result',
      desc: '',
      args: [],
    );
  }

  /// `Well done! Keep going and don't be lazy, you'll get better results tomorrow`
  String get good_job {
    return Intl.message(
      'Well done! Keep going and don\'t be lazy, you\'ll get better results tomorrow',
      name: 'good_job',
      desc: '',
      args: [],
    );
  }

  /// `Let's acquire some healthy habits and add them to your daily routine`
  String get healthy_habits {
    return Intl.message(
      'Let\'s acquire some healthy habits and add them to your daily routine',
      name: 'healthy_habits',
      desc: '',
      args: [],
    );
  }

  /// `Let's see how you spend your day with some relaxation`
  String get relaxation_time {
    return Intl.message(
      'Let\'s see how you spend your day with some relaxation',
      name: 'relaxation_time',
      desc: '',
      args: [],
    );
  }

  /// `Yoga and Breathing Exercises`
  String get yoga_breathing {
    return Intl.message(
      'Yoga and Breathing Exercises',
      name: 'yoga_breathing',
      desc: '',
      args: [],
    );
  }

  /// `Walking Outdoor`
  String get walking_outdoor {
    return Intl.message(
      'Walking Outdoor',
      name: 'walking_outdoor',
      desc: '',
      args: [],
    );
  }

  /// `Reading and Relaxation`
  String get reading_relaxation {
    return Intl.message(
      'Reading and Relaxation',
      name: 'reading_relaxation',
      desc: '',
      args: [],
    );
  }

  /// `lets See How You Relax`
  String get lets_see_how_you_relax {
    return Intl.message(
      'lets See How You Relax',
      name: 'lets_see_how_you_relax',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Reading`
  String get reading {
    return Intl.message(
      'Reading',
      name: 'reading',
      desc: '',
      args: [],
    );
  }

  /// `Book Details`
  String get book_details {
    return Intl.message(
      'Book Details',
      name: 'book_details',
      desc: '',
      args: [],
    );
  }

  /// `Author`
  String get author {
    return Intl.message(
      'Author',
      name: 'author',
      desc: '',
      args: [],
    );
  }

  /// `Publisher`
  String get publisher {
    return Intl.message(
      'Publisher',
      name: 'publisher',
      desc: '',
      args: [],
    );
  }

  /// `Publication Date`
  String get publication_date {
    return Intl.message(
      'Publication Date',
      name: 'publication_date',
      desc: '',
      args: [],
    );
  }

  /// `Pages Count`
  String get pages_count {
    return Intl.message(
      'Pages Count',
      name: 'pages_count',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid time`
  String get please_enter_valid_time {
    return Intl.message(
      'Please enter a valid time',
      name: 'please_enter_valid_time',
      desc: '',
      args: [],
    );
  }

  /// `lets Gain Healthy Habits`
  String get lets_gain_healthy_habits {
    return Intl.message(
      'lets Gain Healthy Habits',
      name: 'lets_gain_healthy_habits',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get loading {
    return Intl.message(
      'Loading...',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `Liked Posts`
  String get liked_posts {
    return Intl.message(
      'Liked Posts',
      name: 'liked_posts',
      desc: '',
      args: [],
    );
  }

  /// `Liked Podcasts`
  String get liked_podcasts {
    return Intl.message(
      'Liked Podcasts',
      name: 'liked_podcasts',
      desc: '',
      args: [],
    );
  }

  /// `Liked Books`
  String get liked_books {
    return Intl.message(
      'Liked Books',
      name: 'liked_books',
      desc: '',
      args: [],
    );
  }

  /// `Liked Blogs`
  String get liked_blogs {
    return Intl.message(
      'Liked Blogs',
      name: 'liked_blogs',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Edit Name`
  String get edit_name {
    return Intl.message(
      'Edit Name',
      name: 'edit_name',
      desc: '',
      args: [],
    );
  }

  /// `Edit Bio`
  String get edit_bio {
    return Intl.message(
      'Edit Bio',
      name: 'edit_bio',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message(
      'Retry',
      name: 'retry',
      desc: '',
      args: [],
    );
  }

  /// `Choose Image`
  String get choose_image {
    return Intl.message(
      'Choose Image',
      name: 'choose_image',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection`
  String get noInternetMessage {
    return Intl.message(
      'No internet connection',
      name: 'noInternetMessage',
      desc: '',
      args: [],
    );
  }

  /// `No Internet`
  String get noInternetTitle {
    return Intl.message(
      'No Internet',
      name: 'noInternetTitle',
      desc: '',
      args: [],
    );
  }

  /// `Still no internet connection`
  String get stillNoInternet {
    return Intl.message(
      'Still no internet connection',
      name: 'stillNoInternet',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get gallery {
    return Intl.message(
      'Gallery',
      name: 'gallery',
      desc: '',
      args: [],
    );
  }

  /// `Save Changes`
  String get save_changes {
    return Intl.message(
      'Save Changes',
      name: 'save_changes',
      desc: '',
      args: [],
    );
  }

  /// `Your Podcasts`
  String get your_podcasts {
    return Intl.message(
      'Your Podcasts',
      name: 'your_podcasts',
      desc: '',
      args: [],
    );
  }

  /// `Your Library`
  String get your_library {
    return Intl.message(
      'Your Library',
      name: 'your_library',
      desc: '',
      args: [],
    );
  }

  /// `Enter bio`
  String get enter_bio {
    return Intl.message(
      'Enter bio',
      name: 'enter_bio',
      desc: '',
      args: [],
    );
  }

  /// `Enter name`
  String get enter_name {
    return Intl.message(
      'Enter name',
      name: 'enter_name',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to logout?`
  String get logout_confirmation {
    return Intl.message(
      'Are you sure you want to logout?',
      name: 'logout_confirmation',
      desc: '',
      args: [],
    );
  }

  /// `Your Posts`
  String get your_posts {
    return Intl.message(
      'Your Posts',
      name: 'your_posts',
      desc: '',
      args: [],
    );
  }

  /// `Your Favorite Articles`
  String get your_favorite_articles {
    return Intl.message(
      'Your Favorite Articles',
      name: 'your_favorite_articles',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
