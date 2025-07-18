import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'pt_BR': {
      'profile': 'Perfil',
      'my_account': 'Minha Conta',
      'change_language': 'Mudar Idioma',
      'logout': 'Sair',
      'edit_profile': 'Editar Perfil',
      'change_password': 'Mudar Senha',
      'are_you_sure': 'Você tem certeza?',
      'do_you_want_to_logout': 'Você quer sair?',
      'cancel': 'Cancelar',
      'message': 'Mensagem',
      'call': 'Ligar',
      'hello': 'Olá',
      'no_billing_data': 'Nenhum dado de faturamento disponível',
      'recent_payment': 'Pagamento Recente',
      'see_all': 'Ver Todos',
      'comunagua_water_bill': 'Conta de Água ComunAgua',
      'meter_number': 'Número do Medidor',
      'exp_date': 'Data de Expiração',
      'current_reading': 'Leitura Atual',
      'last_month_reading': 'Leitura do Mês Passado',
      'price_per_m3': 'Preço por m³',
      'minimum_fee': 'Taxa Mínima',
      'total_bill_of_this_month': 'Conta Total deste Mês',
      'the_status_of_bill': 'O Status da Conta',
      'confirm_payment': 'Confirmar Pagamento',
      'confirm_payment_message':
          'O valor da fatura será deduzido do seu saldo de recarga. Você quer prosseguir?',
      'proceed': 'Prosseguir',
      'pay_now': 'Pague Agora',
      'instant_top_up': 'Recarga Instantânea',
      'set_new_password': 'Definir Nova Senha',
      'new_password': 'Nova Senha',
      'confirm_password': 'Confirmar Senha',
      'new_password_cannot_be_empty': 'A nova senha não pode estar vazia.',
      'new_password_min_length':
          'A nova senha deve ter pelo menos 8 caracteres.',
      'confirm_password_cannot_be_empty':
          'A confirmação da senha não pode estar vazia.',
      'confirm_password_min_length':
          'A confirmação da senha deve ter pelo menos 8 caracteres.',
      'passwords_do_not_match': 'As senhas não correspondem.',
      'verification_code': 'Código de Verificação',
      'verify': 'Verificar',
      'history': 'Histórico',
      'date': 'Data',
      'top_up': 'Recarregar',
      'add_request': 'Adicionar Pedido',
      'payment': 'Pagamento',
      'request_to_admin_to_approve': 'Pedido para Aprovação do Administrador',
      'transaction_id': 'ID da Transação',
      'attachment_pdf_only': 'Anexo (apenas PDF)',
      'top_up_guidelines': 'Diretrizes de Recarga',
      'incomplete_request': 'Pedido Incompleto',
      'enter_transaction_id_and_attach_pdf':
          'Por favor, insira o ID da Transação e anexe um arquivo PDF',
      'submit': 'Enviar',
      'done': 'Feito',
      'success': 'Sucesso',
      'request_approval_time':
          'Por favor, aguarde até 24 horas para que seu recibo seja aprovado.',
      'select_payment_method': 'Selecione seu Método de Pagamento',
      'bank_transfer': 'Transferência Bancária',
      'select_month': 'Selecione o Mês',
      'amount': 'Valor',
      'enter_my_mobile_number': 'Digite meu número de celular',
      'confirm_to_pay': 'Confirmar Pagamento',
      'payment_successful': 'Seu pagamento foi concluído com sucesso!',
      'january': 'Janeiro',
      'february': 'Fevereiro',
      'march': 'Março',
      'april': 'Abril',
      'may': 'Maio',
      'june': 'Junho',
      'july': 'Julho',
      'august': 'Agosto',
      'september': 'Setembro',
      'october': 'Outubro',
      'november': 'Novembro',
      'december': 'Dezembro',
      'm_pesa': 'M-Pesa',
      'e_mola': 'E-Mola',
      'invoice': 'Fatura',
      'personal_information': 'Informação Pessoal',
      'name': 'Nome',
      'number': 'Número',
      'location': 'Localização',
      'invoice_details': 'Detalhes da Fatura',
      'meter_no': 'Nº do Medidor',
      'payment_month': 'Mês de Pagamento',
      'previous_reading': 'Leitura Anterior',
      'consumption': 'Consumo',
      'total_amount': 'Valor Total',
      'download_invoice': 'Baixar Fatura',
      'go_to_home': 'Ir para a Página Inicial',
      'invoice_downloaded': 'Fatura baixada com sucesso',
      'per_unit_charge': 'Cobrança por Unidade',
      'minimum_bill': 'Fatura Mínima',
      'penalty_charge': 'Taxa de Penalidade',
      'payment_with': 'Pagamento Com',
      'status': 'Status',
      'available_every_day': 'Disponível todos os dias, a todas as horas',
      'guidelines': 'Diretrizes',
      'notifications': 'Notificações',
      'current_password': 'Senha Atual',
      'update': 'Atualizar',
      'monthly_water_use': 'Uso Mensal de Água',
      'no_data_available': 'Nenhum dado disponível',
      'monthwise_report': 'Relatório Mensal',
      'error_loading_chart_data': 'Erro ao carregar dados do gráfico',
      'email or phone number': 'e-mail or número de telefone',
      'password': 'Senha',
      'forgot_password': 'Esqueceu a senha?',
      'log_in': 'Entrar',
      'sign_up': 'Inscrever-se',
      'full_name': 'Nome Completo',
      'phone_number': 'Número de Telefone',
      'date_of_birth': 'Data de Nascimento',
      'profile_type': 'Tipo de Perfil',
      'personal_use': 'Uso Pessoal',
      'broker_merchant': 'Corretor/Comerciante',
      'select_profile': 'Selecionar Perfil',
      'id_verified': 'ID Verificado',
      'upload_your_id': 'Carregue sua Identidade',
      'already_have_account': 'Já tem uma conta? ',
      'verification_successful': 'Sua verificação foi bem-sucedida!',
      'continue_button': 'Continuar',
      'error': 'Error',
      'dismiss': 'Dismiss',
      'please_enter_email_or_phone': 'Please enter your email or phone number.',
      'please_enter_valid_email': 'Please enter a valid email address.',
      'please_enter_valid_phone': 'Please enter a valid phone number.',
      'password_at_least_8_characters': 'Password must be at least 8 characters long.',
      'token_not_found': 'Token not found in response.',
      'new_password_at_least_8_characters': 'New password must be at least 8 characters long.',
      'authorization_token_not_found': 'Authorization token not found.',
      'profile_updated_successfully': 'Profile updated successfully.',
      'exception': 'Exception',
      'an_error_occurred': 'An error occurred: %s',
      'no_file_selected': 'No file selected',
      'please_fill_all_fields': 'Please fill all fields',
      'unknown_error': 'Unknown error',
      'catch_error': 'Catch Error: %s',
      'all_fields_are_required': 'All fields are required',
      'new_password_and_confirm_password_do_not_match': 'New password and confirm password do not match',
      'new_password_at_least_6_characters': 'New password must be at least 6 characters long',
      'please_select_a_picture': 'Please select a picture',
      'please_select_an_image': 'Please select an image',
      'auth_error': 'Auth Error',
      'no_access_token_found': 'No access token found',
      'profile_update_failed': 'Profile update failed',
      'at_catch': 'At Catch: %s',
      'current_password_at_least_8_characters': 'Current password must be at least 8 characters long.',
      'new_password_cannot_be_same_as_current': 'New password cannot be the same as the current password.',
      'image_selected': 'Image Selected',
      'you_have_successfully_selected_an_image': 'You have successfully selected an image.',
      'no_image_selected': 'No Image Selected',
      'you_didnt_select_any_image': 'You didn\'t select any image.',
      'file_error': 'File Error',
      'the_selected_image_file_does_not_exist': 'The selected image file does not exist.',
      'failed_to_update_profile': 'Failed to update profile. Status code: %s',
      'account_created_successfully': 'Account created successfully!',
      'profile_picture_selected_successfully': 'Profile picture selected successfully',
      'profile_picture_captured_successfully': 'Profile picture captured successfully',
      'you_have_been_logged_out_successfully': 'You have been logged out successfully',
      'comunagua': 'ComunAgua',
    },
    'en_US': {
      'profile': 'Profile',
      'my_account': 'My Account',
      'change_language': 'Switch Language',
      'logout': 'Logout',
      'edit_profile': 'Edit Profile',
      'change_password': 'Change Password',
      'are_you_sure': 'Are You Sure?',
      'do_you_want_to_logout': 'Do you want to log out?',
      'cancel': 'Cancel',
      'message': 'Message',
      'call': 'Call',
      'hello': 'Hello',
      'no_billing_data': 'No billing data available',
      'recent_payment': 'Recent Payment',
      'see_all': 'See all',
      'comunagua_water_bill': 'ComunAgua Water Bill',
      'meter_number': 'Meter Number',
      'exp_date': 'Exp Date',
      'current_reading': 'Current Reading',
      'last_month_reading': 'Last Month Reading',
      'price_per_m3': 'Price Per m³',
      'minimum_fee': 'Minimum Fee',
      'total_bill_of_this_month': 'Total Bill of this Month',
      'status': 'Status',
      'confirm_payment': 'Confirm Payment',
      'confirm_payment_message':
          'The amount of the bill will be deducted from your top-up balance. Do you want to proceed?',
      'proceed': 'Proceed',
      'pay_now': 'Pay Now',
      'instant_top_up': 'Instant Top Up',
      'set_new_password': 'Set New Password',
      'new_password': 'New Password',
      'confirm_password': 'Confirm Password',
      'new_password_cannot_be_empty': 'New password cannot be empty.',
      'new_password_min_length':
          'New password must be at least 8 characters long.',
      'confirm_password_cannot_be_empty': 'Confirm password cannot be empty.',
      'confirm_password_min_length':
          'Confirm password must be at least 8 characters long.',
      'passwords_do_not_match': 'Passwords do not match.',
      'verification_code': 'Verification Code',
      'verify': 'Verify',
      'history': 'History',
      'date': 'Date',
      'top_up': 'Top Up',
      'add_request': 'Add Request',
      'payment': 'Payment',
      'request_to_admin_to_approve': 'Request to Admin to Approve',
      'transaction_id': 'Transaction ID',
      'attachment_pdf_only': 'Attachment (PDF only)',
      'top_up_guidelines': 'Top Up Guidelines',
      'incomplete_request': 'Incomplete Request',
      'enter_transaction_id_and_attach_pdf':
          'Please enter Transaction ID and attach a PDF file',
      'submit': 'Submit',
      'done': 'Done',
      'success': 'Success',
      'request_approval_time':
          'Please allow up to 24 hours for your receipt to be approved.',
      'select_payment_method': 'Select Your Payment Method',
      'bank_transfer': 'Bank Transfer',
      'select_month': 'Select Month',
      'amount': 'Amount',
      'enter_my_mobile_number': 'Enter my Mobile number',
      'confirm_to_pay': 'Confirm to Pay',
      'payment_successful': 'Your payment is successfully Complete!',
      'january': 'January',
      'february': 'February',
      'march': 'March',
      'april': 'April',
      'may': 'May',
      'june': 'June',
      'july': 'July',
      'august': 'August',
      'september': 'September',
      'october': 'October',
      'november': 'November',
      'december': 'December',
      'm_pesa': 'M-Pesa',
      'e_mola': 'E-Mola',
      'invoice': 'Invoice',
      'personal_information': 'Personal Information',
      'name': 'Name',
      'number': 'Number',
      'location': 'Location',
      'invoice_details': 'Invoice Details',
      'meter_no': 'Meter No',
      'payment_month': 'Payment Month',
      'previous_reading': 'Previous Reading',
      'consumption': 'Consumption',
      'total_amount': 'Total Amount',
      'download_invoice': 'Download Invoice',
      'go_to_home': 'Go to Home',
      'invoice_downloaded': 'Invoice downloaded successfully',
      'per_unit_charge': 'Per Unit Charge',
      'minimum_bill': 'Minimum Bill',
      'penalty_charge': 'Penalty Charge',
      'payment_with': 'Payment With',
      'available_every_day': 'Available every day, at all hours',
      'guidelines': 'Guidelines',
      'notifications': 'Notifications',
      'current_password': 'Current Password',
      'update': 'Update',
      'monthly_water_use': 'Monthly Water Use',
      'no_data_available': 'No data available',
      'monthwise_report': 'Monthwise Report',
      'error_loading_chart_data': 'Error loading chart data',
      'email or phone number': 'Email or Phone Number',
      'password': 'Password',
      'forgot_password': 'Forgot password?',
      'log_in': 'Log in',
      'sign_up': 'Sign Up',
      'full_name': 'Full Name',
      'phone_number': 'Phone Number',
      'date_of_birth': 'Date of Birth',
      'profile_type': 'Profile Type',
      'personal_use': 'Personal Use',
      'broker_merchant': 'Broker/Merchant',
      'select_profile': 'Select Profile',
      'id_verified': 'ID-Verified',
      'upload_your_id': 'Upload your ID',
      'already_have_account': 'Already have an account? ',
      'verification_successful': 'Your verification was successful!',
      'continue_button': 'Continue',
      'error': 'Error',
      'dismiss': 'Dismiss',
      'please_enter_email_or_phone': 'Please enter your email or phone number.',
      'please_enter_valid_email': 'Please enter a valid email address.',
      'please_enter_valid_phone': 'Please enter a valid phone number.',
      'password_at_least_8_characters': 'Password must be at least 8 characters long.',
      'token_not_found': 'Token not found in response.',
      'new_password_at_least_8_characters': 'New password must be at least 8 characters long.',
      'authorization_token_not_found': 'Authorization token not found.',
      'profile_updated_successfully': 'Profile updated successfully.',
      'exception': 'Exception',
      'an_error_occurred': 'An error occurred: %s',
      'no_file_selected': 'No file selected',
      'please_fill_all_fields': 'Please fill all fields',
      'unknown_error': 'Unknown error',
      'catch_error': 'Catch Error: %s',
      'all_fields_are_required': 'All fields are required',
      'new_password_and_confirm_password_do_not_match': 'New password and confirm password do not match',
      'new_password_at_least_6_characters': 'New password must be at least 6 characters long',
      'please_select_a_picture': 'Please select a picture',
      'please_select_an_image': 'Please select an image',
      'auth_error': 'Auth Error',
      'no_access_token_found': 'No access token found',
      'profile_update_failed': 'Profile update failed',
      'at_catch': 'At Catch: %s',
      'current_password_at_least_8_characters': 'Current password must be at least 8 characters long.',
      'new_password_cannot_be_same_as_current': 'New password cannot be the same as the current password.',
      'image_selected': 'Image Selected',
      'you_have_successfully_selected_an_image': 'You have successfully selected an image.',
      'no_image_selected': 'No Image Selected',
      'you_didnt_select_any_image': 'You didn\'t select any image.',
      'file_error': 'File Error',
      'the_selected_image_file_does_not_exist': 'The selected image file does not exist.',
      'failed_to_update_profile': 'Failed to update profile. Status code: %s',
      'account_created_successfully': 'Account created successfully!',
      'profile_picture_selected_successfully': 'Profile picture selected successfully',
      'profile_picture_captured_successfully': 'Profile picture captured successfully',
      'you_have_been_logged_out_successfully': 'You have been logged out successfully',
      'comunagua': 'ComunAgua',
    }
  };
}
