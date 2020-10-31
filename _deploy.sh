set -e

[ -z "${GITHUB_PAT}" ] && exit 0
[ "${TRAVIS_BRANCH}" != "main" ] && exit 0

git config --global user.email "leg.ifgoiano@gmail.com"
git config --global user.name "leg-ifgoiano"

git clone -b gh-pages https://${GITHUB_PAT}@github.com/${TRAVIS_REPO_SLUG}.git site
cd site
cp -r ../docs/* ./
git add --all *
git commit -m "first launch" || true
git push -q origin gh-pages
