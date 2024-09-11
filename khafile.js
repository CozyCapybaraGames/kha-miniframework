let project = new Project('CCG Kha Starter');
await project.addProject('Subprojects/keeb');
project.addAssets('Assets/**');
project.addShaders('Shaders/**');
project.addSources('Sources');
project.addDefine('kha_html5_disable_automatic_side_adjust');
resolve(project);
