***Nextra***

Aplicativo de notícias que reúne conteúdos das principais fontes em um só lugar. Busca e exibição de informações em tempo real, além de oferecer acesso offline às notícias salvas.

**Features**:

- Home → exibe as principais fontes de notícias, manchetes em destaque e artigos em geral.
- Páginas de Detalhes → permite navegar para detalhes de uma fonte de notícia específica ou de uma manchete selecionada.
- WebView → abre a notícia completa em uma visualização integrada, acessando a URL original.
- Persistência (Offline) → mantém acesso às notícias armazenadas localmente via SQLite, mesmo sem conexão.
- Cache de Imagens → armazena imagens localmente para otimizar carregamento e economizar dados.

**Arquitetura e organização do código**:

O Nextra utiliza o padrão MVVM, com Provider para injeção de dependências e ValueNotifier para gerenciamento de estado.

```plaintext
lib/
 │── common/
 │    ├── components/ 
 │    ├── helpers/
 |    └── service/ 
 ├── home/
 │    ├── data/
 │    │    ├── data_sources/
 │    │    ├── models/
 │    │    └── repositories/
 │    └── presentation/
 │         ├── pages/
 │         └── view_models/
 ├── news_source_details/
 │    ├── data/
 │    └── presentation/
 └── web_view/
      ├── data/
      └── presentation/
```

- Camadas
  - Data → responsável pela comunicação com APIs, CMS e banco local (SQLite).
    - Implementa Data Sources para lidar com diferentes origens (remota e local).

```plainText
class HomeLocalDataSource {
  final NewsSourceDAO newsSourceDao;
  final BannerDAO bannerDao;
  final ArticleDAO articleDao;

  HomeLocalDataSource({
    required this.newsSourceDao,
    required this.bannerDao,
    required this.articleDao,
  });

  final String _where = 'category = ?';
  final List<Object?> _whereArgs = ['general'];

  Future<HomeData> fetch() async {
    final newsSourcesSqlite = await newsSourceDao.fetchAll();
    final newsSources = newsSourcesSqlite
        .map((element) => NewsSourceDTO.fromSqlite(element))
        .toList();

    final bannersSqlite = await bannerDao.fetchAll();
    final banners = bannersSqlite
        .map((element) => BannerDTO.fromSqlite(element))
        .toList();

    final articlesSqlite = await articleDao.fetchWhere(
      where: _where,
      whereArgs: _whereArgs,
    );

    final articles = articlesSqlite
        .map((element) => ArticleDTO.fromSqlite(element))
        .toList();

    return HomeData(
      newsSources: newsSources,
      banners: banners,
      articles: articles,
    );
  }

  Future<void> deleteAll({required bool includingChildren}) async {}
}
```

```plainText
class HomeRemoteDataSource {
  final ApiServiceProtocol apiService;
  final CmsConnectionProtocol cmsConnection;

  HomeRemoteDataSource({required this.apiService, required this.cmsConnection});

  Future<HomeData> fetch() async {
    HomeCMSModel.registerChildren();

    try {
      final cmsModel = await cmsConnection.findAll<HomeCMSModel>();
      final homeDto = HomeDTO.fromCMS(cmsModel);
      final newsSources = NewsSourceDTO.getActiveNewsSources(homeDto.carousel.newsSources);
      final banners = BannerDTO.getActiveBanners(homeDto.banners);

      final articleResponse = await apiService.fetchResponse(
        fromJson: ArticleResponse.fromJson,
        properties: {'category': 'general'},
      );

      return HomeData(
        newsSources: newsSources,
        banners: banners,
        articles: articleResponse.articles
      );
    } on ApiException catch (error) {
      return HomeData(errorMessage: error.userMessage);
    } catch (_) {
      return HomeData(errorMessage: 'Failed to load content. Please connect to the internet.');
    }
  }
}
```


  
    
    
  - Os Repositories encapsulam as regras de acesso aos dados.

```plainText
class HomeRepository {
  final HomeLocalDataSource local;
  final HomeRemoteDataSource remote;
  final AppCacheManager cacheManager;
  final InternetConnectionChecker internetConnectionChecker;

  HomeRepository({
    required this.local,
    required this.remote,
    required this.cacheManager,
    required this.internetConnectionChecker,
  });

  Future<HomeData> fetchData() async {}

  Future<void> _clearAndPersist(HomeData data) async {}

  Future<void> clearAll(HomeData data, {bool includingChildren = false}) async {}

  Future<void> _persist(HomeData data) async {}

  Future<void> _cacheImages(HomeData data) async {}
```

    

  - Presentation → contém as Pages, ViewModels e lógicas de UI.
     - Cada ViewModel utiliza ValueNotifier notificar que a UI deve reagir.
     - As Pages escutam as mudanças e atualizam a UI a partir de um ValueListenableBuilder.
   
```plainText
class WebViewModel {
  final WebViewRepository repository;
  final ValueNotifier<WebViewData> data = ValueNotifier(WebViewData());

  WebViewModel({required this.repository});

  Future<void> fetch() async {
    data.value = WebViewData();
    data.value = await repository.fetchData();
  }
}
```

```plainText
class WebViewPage extends StatefulWidget {
  static const routeId = '/webView';

  const WebViewPage({super.key});

  @override
  State<StatefulWidget> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late final WebViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = context.read<WebViewModel>();
    _initialize();
  }

  Future<void> _initialize() async {
    await _viewModel.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _viewModel.data, 
      builder: (_, data, _) {
        return Scaffold();
  }
}
```


   

- Gerenciamento de Dependências
   - O Provider injeta as dependências na inicialização do app (main.dart).
   - São injetados repositórios, view models e outros serviços.

```plainText
runApp(
    MultiProvider(
      providers: [
        Provider<HomeViewModel>(
          create: (_) => HomeViewModel(repository: homeRepository),
        ),
        Provider<NewsSourceDetailsViewModel>(
          create: (_) => NewsSourceDetailsViewModel(repository: newsSourceDetailsRepository),
        ),
        Provider<WebViewModel>(
          create: (_) => WebViewModel(repository: webViewRespository),
        ),
      ],
      child: const MyApp(),
    ),
  );
```

**Detalhes técnicos**

- Firebase Remote Config
  - Usado para guardar as chaves utilizados nos serviços de API e CMS
 
```plainText
class TokenProvider {
  final String? accessTokenCDA;
  final String? spaceIdCDA;
  final String? accessTokenCMA;
  final String? newsApiKey;

  TokenProvider._(
    this.accessTokenCDA,
    this.spaceIdCDA,
    this.accessTokenCMA,
    this.newsApiKey
  );

  static Future<TokenProvider> create() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
    );

    final remoteConfig = FirebaseRemoteConfig.instance;

    await remoteConfig.fetchAndActivate();

    return TokenProvider._(
      remoteConfig.getString('CONTENTFUL_CDA_ACCESS_TOKEN'),
      remoteConfig.getString('CONTENTFUL_SPACE_ID'),
      remoteConfig.getString('CONTENTFUL_CMA_ACCESS_TOKEN'),
      remoteConfig.getString('NEWS_API_KEY')
    );
  }
}
```



- CMS
  - Contentful (headless CMS) foi o utilizado.
  - A comunicação entre o CMS e o app ocorre atráves de GraphQL

<img width="2888" height="650" alt="Screenshot 2025-11-07 at 02 34 54" src="https://github.com/user-attachments/assets/c5acdc25-af72-4c1e-9649-94247d1cf3ba" />

```plainText
abstract class CmsConnectionProtocol {
  Future<T> findAll<T extends CmsModelProtocol>();
  void initClient({
    required String? accessToken,
    required String? spaceId,
    String environment = 'master'
  });
}

class CmsConnection implements CmsConnectionProtocol {
  late final GraphQLClient _client;

  @override
  void initClient({
    required String? accessToken, 
    required String? spaceId,
    String environment = 'master'
  }) {
    if (accessToken == null || spaceId == null) {
      throw Exception('Missing accessToken or spaceId');
    }

    final String endpoint =
        'https://graphql.contentful.com/content/v1/spaces/$spaceId/environments/$environment';

    final HttpLink httpLink = HttpLink(
      endpoint,
      defaultHeaders: {'Authorization': 'Bearer $accessToken'},
    );

    _client = GraphQLClient(link: httpLink, cache: GraphQLCache());
  }

  @override
  Future<T> findAll<T extends CmsModelProtocol>() async {
    final String contentType = CmsModelProtocol.contentTypeOf<T>();
    final String fieldsQuery = CmsModelProtocol.fieldsQueryOf<T>();

    final String query = '''
      query {
        ${contentType}Collection(limit: 1) {
          items {
            $fieldsQuery
          }
        }
      }
    ''';

    final result = await _client.query(QueryOptions(document: gql(query)));

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final items = result.data?['${contentType}Collection']?['items'] as List?;

    if (items == null || items.isEmpty) {
      throw Exception('No $T content found');
    }

    return CmsModelProtocol.fromJsonOf<T>(items.first);
  }
}
```

- API
  - A API pública utilizada foi a <a href="https://newsapi.org" target="_blank">News API</a>
  - As requisições são feitas utilizando REST
 
```plainText
class ApiService implements ApiServiceProtocol {
  final String? apiKey;
  final dio = Dio(BaseOptions(baseUrl: 'https://newsapi.org/v2/'));

  ApiService({required this.apiKey});

  @override
  Future<T> fetchResponse<T>({
    String endpoint = 'top-headlines',
    required Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic>? properties
  }) async {
    final response = await dio.get(
      endpoint,
      queryParameters: properties
    );

    return fromJson(response.data);
  }
}
```

- Persistência
  - Feita através do SQLite
 
```plainText
abstract class SqliteProtocol<T> {
  String get table;
  String get createTableQuery;
  Map<String, Object?> toSqliteMap();
  T toSqliteModel(Map<String, Object?> map);
}
```

```plainText
class NewsSourceSqliteModel implements SqliteProtocol<NewsSourceSqliteModel> {
  final String name;
  final String? logoUrl;
  final String? sourceId;
  final bool isActive;

  const NewsSourceSqliteModel({
    this.name = '',
    this.logoUrl,
    this.sourceId,
    this.isActive = false,
  });

  @override
  String get table => 'news_sources';
  
  @override
  String get createTableQuery => '''
    CREATE TABLE $table (
      name TEXT PRIMARY KEY,
      logoUrl TEXT,
      sourceId TEXT,
      isActive INTEGER NOT NULL
    );
  ''';
  
  @override
  Map<String, Object?> toSqliteMap() {
    return {
      'name': name,
      'logoUrl': logoUrl,
      'sourceId': sourceId,
      'isActive': isActive ? 1 : 0
    };
  }
  
  @override
  NewsSourceSqliteModel toSqliteModel(Map<String, Object?> map) {
    return NewsSourceSqliteModel(
      name: map['name'] as String,
      logoUrl: map['logoUrl'] as String?,
      sourceId: map['sourceId'] as String?,
      isActive: (map['isActive'] as int) == 1
    );
  }
}
```

- Models
  - DTOs (Data Transfer Objects)
    - Responsáveis por transferir e converter dados entre diferentes camadas, garantindo compatibilidade entre a API, o banco local e o app.
  - CMS Models
    - Representam os dados vindos do Contentful.
    - Possuem registro automático, definição de queries GraphQL e conversão entre JSON e modelo interno.
  - DAOs (Data Access Objects)
    - Gerenciam a persistência local dos dados, oferecendo métodos genéricos no SQLite.
  - SQLite Models
    - Definem a estrutura das tabelas e mapeam os objetos e registros do banco.
  - Protocols
    - Contratos genéricos que padronizam operações e facilitam a escalabilidade e reuso do código.




