# Automate inclusion in github
It is easy to have this part automated in your github mod. It is about automation, right?
This is done by adding this repository to your git repository as a submodule.

### Adding the submodule for the first time
To add the module you first need the remote link of the submodule. You can find the remote url on each git repo:
![remote url location](https://help.github.com/assets/images/help/repository/remotes-url.png)
For this project it is
```
https://github.com/LovelySanta/FactorioModLib.git
```

The next step is to add it to a location in your project. In this example it will add the submodule to a folder named LSlib, located in the root directory of the mod.
```
git submodule add https://github.com/LovelySanta/FactorioModLib.git LSlib
```

The next step is to initialize and clone the submodule
```
git submodule init
git submodule update
```

As last step, we add it to the repository
```
git add LSlib
git commit -m "Added LSlib."
git push origin master
```

When you never used modules before, it won't download the module content automaticly when pulling from your repo. Becose you want to use the script you'll have to change that setting by running the next command, or pull them manualy.
```
git config --global submodule.recurse true
```

### Update the submodule to a newer version
First we change to the submodule directory, it should say you're on a different branch then.
```
cd LSlib
```

The next step is to pull the changes from this repository
```
git checkout master
git pull origin master
```

As final step, you move back to your branch and commit the changes
```
cd ..
git add LSlib
git commit -m "Updated Lslib."
git push origin master
```
