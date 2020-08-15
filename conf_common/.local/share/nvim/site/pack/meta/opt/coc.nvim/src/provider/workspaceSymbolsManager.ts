import { v4 as uuid } from 'uuid'
import { CancellationToken, Disposable, SymbolInformation } from 'vscode-languageserver-protocol'
import { TextDocument } from 'vscode-languageserver-textdocument'
import { WorkspaceSymbolProvider } from './index'

export default class WorkspaceSymbolManager implements Disposable {
  private providers: Map<string, WorkspaceSymbolProvider> = new Map()

  public register(provider: WorkspaceSymbolProvider): Disposable {
    let id = uuid()
    this.providers.set(id, provider)
    return Disposable.create(() => {
      this.providers.delete(id)
    })
  }

  public async provideWorkspaceSymbols(
    _document: TextDocument,
    query: string,
    token: CancellationToken
  ): Promise<SymbolInformation[]> {
    let entries = Array.from(this.providers.entries())
    if (!entries.length) return []
    let res: SymbolInformation[] = []
    await Promise.all(entries.map(o => {
      let [id, p] = o
      return Promise.resolve(p.provideWorkspaceSymbols(query, token)).then(item => {
        if (item) {
          (item as any).source = id
          res.push(...item)
        }
      })
    }))
    return res
  }

  public async resolveWorkspaceSymbol(
    symbolInfo: SymbolInformation,
    token: CancellationToken
  ): Promise<SymbolInformation> {
    let provider = this.providers.get((symbolInfo as any).source)
    if (!provider) return
    if (typeof provider.resolveWorkspaceSymbol != 'function') {
      return Promise.resolve(symbolInfo)
    }
    return await Promise.resolve(provider.resolveWorkspaceSymbol(symbolInfo, token))
  }

  public hasProvider(): boolean {
    return this.providers.size > 0
  }

  public dispose(): void {
    this.providers = new Map()
  }
}
