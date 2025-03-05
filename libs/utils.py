from robot.libraries.BuiltIn import BuiltIn
from robot.api.deco import keyword
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

@keyword(name='Scroll To Element')
def scroll_to_element(locator):
    """
    Realiza scroll até que o elemento especificado pelo locator esteja visível.

    Args:
        locator (str): O localizador do elemento (XPath, CSS Selector, etc.).

    Raises:
        Exception: Caso o elemento não seja encontrado.
    """
    # Obtém a instância do SeleniumLibrary
    seleniumlib = BuiltIn().get_library_instance('SeleniumLibrary')
    driver = seleniumlib.driver  # Obtém o WebDriver atual

    try:
        # Localiza o elemento usando o localizador (assumindo que é XPath)
        element = driver.find_element(By.XPATH, locator)
        # Realiza scroll até o elemento usando JavaScript
        driver.execute_script("arguments[0].scrollIntoView(true);", element)
    except Exception as e:
        raise Exception(f"Não foi possível encontrar o elemento: {locator}. Erro: {str(e)}")


@keyword(name='Clear Text Element')
def clear_text_element(locator, locator_type="xpath"):
    """
    Limpa completamente o texto de um campo de entrada (input ou textarea), mesmo que o campo seja protegido.

    Args:
        locator (str): O localizador do elemento (XPath, CSS Selector, etc.).
        locator_type (str): O tipo do localizador (xpath, css, id, etc.). Padrão é "xpath".

    Raises:
        Exception: Caso o elemento não seja encontrado ou não possa ser limpo.
    """
    seleniumlib = BuiltIn().get_library_instance('SeleniumLibrary')
    driver = seleniumlib.driver  # Obtém o WebDriver atual

    try:
        # Seleciona o tipo de localizador
        by = {
            "xpath": By.XPATH,
            "css": By.CSS_SELECTOR,
            "id": By.ID,
            "name": By.NAME,
            "class_name": By.CLASS_NAME,
            "tag_name": By.TAG_NAME,
            "link_text": By.LINK_TEXT,
            "partial_link_text": By.PARTIAL_LINK_TEXT,
        }.get(locator_type.lower(), By.XPATH)  # Padrão: XPath

        # Localiza o elemento
        element = driver.find_element(by, locator)

        # Verifica se o campo é readonly ou disabled
        readonly = element.get_attribute("readonly")
        disabled = element.get_attribute("disabled")

        if readonly or disabled:
            # Remove os atributos usando JavaScript, se necessário
            driver.execute_script("arguments[0].removeAttribute('readonly');", element)
            driver.execute_script("arguments[0].removeAttribute('disabled');", element)

        # Garante o foco no elemento
        element.click()

        # Limpa o texto usando Ctrl+A (seleciona tudo) + Backspace
        element.send_keys(Keys.CONTROL + "a")  # Seleciona todo o texto no campo
        element.send_keys(Keys.BACKSPACE)  # Apaga todo o texto selecionado

        # Como fallback, limpa o valor usando JavaScript (caso o texto ainda esteja presente)
        if element.get_attribute("value") != "":
            driver.execute_script("arguments[0].value = '';", element)

        # Valida se o campo está vazio
        if element.get_attribute("value") != "":
            raise Exception(f"Não foi possível limpar o texto do elemento: {locator}. Valor restante: {element.get_attribute('value')}")

    except Exception as e:
        raise Exception(f"Erro ao limpar o elemento: {locator}. Detalhes: {str(e)}")
    
@keyword(name='Click Text Element')
def click_text_element(locator, locator_type="xpath", timeout=10):
    """
    Realiza o clique em um elemento de texto.

    Args:
        locator (str): O localizador do elemento (XPath, CSS Selector, etc.).
        locator_type (str): O tipo do localizador (xpath, css, id, etc.). Padrão é "xpath".
        timeout (int): O tempo máximo para esperar que o elemento fique clicável. Padrão é 10 segundos.

    Raises:
        Exception: Caso o elemento não seja encontrado ou não esteja clicável.
    """
    seleniumlib = BuiltIn().get_library_instance('SeleniumLibrary')
    driver = seleniumlib.driver  # Obtém o WebDriver atual

    try:
        # Seleciona o tipo de localizador
        by = {
            "xpath": By.XPATH,
            "css": By.CSS_SELECTOR,
            "id": By.ID,
            "name": By.NAME,
            "class_name": By.CLASS_NAME,
            "tag_name": By.TAG_NAME,
            "link_text": By.LINK_TEXT,
            "partial_link_text": By.PARTIAL_LINK_TEXT,
        }.get(locator_type.lower(), By.XPATH)  # Padrão: XPath

        # Aguarda até que o elemento esteja visível e clicável
        element = WebDriverWait(driver, timeout).until(
            EC.element_to_be_clickable((by, locator))
        )

        # Realiza o clique
        element.click()

    except Exception as e:
        raise Exception(f"Erro ao clicar no elemento: {locator}. Detalhes: {str(e)}")