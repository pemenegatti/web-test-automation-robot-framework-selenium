from robot.libraries.BuiltIn import BuiltIn
from robot.api.deco import keyword
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from faker import Faker

_fake = Faker()

# Mapeamento reutilizável de tipos de localizador
_LOCATOR_MAP = {
    "xpath":              By.XPATH,
    "css":                By.CSS_SELECTOR,
    "id":                 By.ID,
    "name":               By.NAME,
    "class_name":         By.CLASS_NAME,
    "tag_name":           By.TAG_NAME,
    "link_text":          By.LINK_TEXT,
    "partial_link_text":  By.PARTIAL_LINK_TEXT,
}


def _get_driver():
    """Retorna a instância do WebDriver atual via SeleniumLibrary."""
    return BuiltIn().get_library_instance('SeleniumLibrary').driver


def _resolve_by(locator_type: str) -> str:
    """Converte o tipo de localizador em constante do Selenium."""
    return _LOCATOR_MAP.get(locator_type.lower(), By.XPATH)


# ─────────────────────────────────────────────
# Keywords de dados fake
# ─────────────────────────────────────────────

@keyword(name='Fake First Name')
def fake_first_name() -> str:
    """Retorna um primeiro nome aleatório."""
    return _fake.first_name()


@keyword(name='Fake Last Name')
def fake_last_name() -> str:
    """Retorna um sobrenome aleatório."""
    return _fake.last_name()


@keyword(name='Fake Postal Code')
def fake_postal_code() -> str:
    """Retorna um código postal aleatório."""
    return _fake.postcode()


# ─────────────────────────────────────────────
# Keywords de interação com elementos
# ─────────────────────────────────────────────

@keyword(name='Scroll To Element')
def scroll_to_element(locator: str) -> None:
    """
    Realiza scroll até que o elemento especificado esteja visível na viewport.

    Args:
        locator (str): XPath do elemento.

    Raises:
        Exception: Caso o elemento não seja encontrado.
    """
    driver = _get_driver()
    try:
        element = driver.find_element(By.XPATH, locator)
        driver.execute_script("arguments[0].scrollIntoView(true);", element)
    except Exception as e:
        raise Exception(f"Não foi possível encontrar o elemento: {locator}. Erro: {str(e)}")


@keyword(name='Clear Text Element')
def clear_text_element(locator: str, locator_type: str = "xpath") -> None:
    """
    Limpa completamente o texto de um campo de entrada, mesmo que seja readonly ou disabled.

    Args:
        locator (str): O localizador do elemento.
        locator_type (str): Tipo do localizador (xpath, css, id, etc.). Padrão: xpath.

    Raises:
        Exception: Caso o elemento não seja encontrado ou não possa ser limpo.
    """
    driver = _get_driver()
    try:
        element = driver.find_element(_resolve_by(locator_type), locator)

        if element.get_attribute("readonly") or element.get_attribute("disabled"):
            driver.execute_script("arguments[0].removeAttribute('readonly');", element)
            driver.execute_script("arguments[0].removeAttribute('disabled');", element)

        element.click()
        element.send_keys(Keys.CONTROL + "a")
        element.send_keys(Keys.BACKSPACE)

        if element.get_attribute("value") != "":
            driver.execute_script("arguments[0].value = '';", element)

        if element.get_attribute("value") != "":
            raise Exception(
                f"Não foi possível limpar o elemento: {locator}. "
                f"Valor restante: {element.get_attribute('value')}"
            )
    except Exception as e:
        raise Exception(f"Erro ao limpar o elemento: {locator}. Detalhes: {str(e)}")


@keyword(name='Click Text Element')
def click_text_element(locator: str, locator_type: str = "xpath", timeout: int = 10) -> None:
    """
    Clica em um elemento aguardando ele ficar clicável.

    Args:
        locator (str): O localizador do elemento.
        locator_type (str): Tipo do localizador (xpath, css, id, etc.). Padrão: xpath.
        timeout (int): Tempo máximo de espera em segundos. Padrão: 10.

    Raises:
        Exception: Caso o elemento não seja encontrado ou não esteja clicável.
    """
    driver = _get_driver()
    try:
        element = WebDriverWait(driver, timeout).until(
            EC.element_to_be_clickable((_resolve_by(locator_type), locator))
        )
        element.click()
    except Exception as e:
        raise Exception(f"Erro ao clicar no elemento: {locator}. Detalhes: {str(e)}")
