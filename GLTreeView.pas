unit GLTreeView;

interface

uses
  GLScene, Classes, ComCtrls;

type
  TGLNode = class(TTreeNode)
  private
    FLinkedObject: TGLBaseSceneObject;
  public
    property LinkedObject: TGLBaseSceneObject read FLinkedObject write FLinkedObject;
  end;

  TGLTreeView = class (TTreeView)
    private
      FOnCreateNodeClass: TTVCreateNodeClassEvent;
    protected
      function CreateNode: TTreeNode; override;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('GLScene', [TGLTreeView]);
end;

function TGLTreeView.CreateNode: TTreeNode;
var
  LClass: TTreeNodeClass;
begin
  LClass := TGLNode;
  if Assigned(FOnCreateNodeClass) then
    FOnCreateNodeClass(Self, LClass);
  Result := LClass.Create(Items);
end;

end.
