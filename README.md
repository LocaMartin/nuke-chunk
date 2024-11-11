<hr>

### Installaton:

```
git clone https://github.com/LocaMartin/nuke-chunk.git
```
```
cd nuke-chunk
```
#### copy the file path:
```
pwd
```
add `nuke-chunk.sh` file path to shell configuration file e.g `.bashrc` or `.zshrc` ( you can check your shell by this command "`echo $0`" )

```
echo "alias nuke-chunk="/<path to nuke-chunk.sh file>/nuke-chunk.sh" >> ~/.zshrc
```

```
source ~/.zshrc
```

#### or
```
echo "alias nuke-chunk="/<path to nuke-chunk.sh file>/nuke-chunk.sh" >> ~/.bashrc
```
```
source ~/.bashrc
```
<hr>

#### Usage:
```
nuke-chunk domain.txt
```
```
nuke-chunk domain.txt -pr
```
```
nuke-chunk domain.txt -tag cve
```
```
nuke-chunk domain.txt -t http/cves/2024/template.yml
```
```
nuke-chunk domain.txt -twek 85 -tag cve
```
```
nuke-chunk domain.txt -twek 85 -t http/cves/2024/template.yml
```
```
nuke-chunk -twek 86
```
#### Flags:

- `-tag` :`<tags>`
- `-t` : `<nuclei template>`
- `-pr`: prints results
- `-twek`: `<number of domain you system os/shell/system can test at once>` e.g 85

<hr>

## warning:

🚨 **Caution Zone 🚨**

This script is powerful but also resource-intensive. It might:
- Consume a lot of internet data
- Cause system crashes if overused

So, please use it wisely and only when you have unlimited internet or access to a VPS that supports heavy tasks!

<hr>

### info

- twek 

this (nuke-chunk.sh) script use these nuclei flags [ `-l`,`-tags`,`-c`, `-silent`, `-rl`,`-bs`,`-project`,`-stream`,`-ss host-spray`,`-mhe` ]

by defult this script run `cve` tag and `85` twek you can use `-tag` , `-twek` flag to  change tag and twek the number of domains every chunk have according to your prefrence.
`-twek` flag will make changes to the value to nuclei flags in the script.

`-twek` flg of `nuke-chunk.sh` shellscript make changes to the vlaue of these nuclei flag inside `nuke-chunk.sh` [ `-c 85`, `-rl 85` ,`-bs 85` `-mhe 85` ]

#### so you will need to use `-twek` command to make it defult value
```
nuke-chunk -twek 85
```
### output

- scan results are automatically stored in `result/chunk_1_result.txt` directory
- combine resuts of all chunks are automatically stored in `result/combine_result/chunkX.txt`
- chunks are added added to `chunks` directory like:
chunks/chunk_1.txt
chunks/chunk_2.txt
chunks/chunk_3.txt
<hr>

#### `nuke-chunk` Is a script to test domains using `nuclei` faster by spliting domain file in chunks and using `parallal` command to test all files at once.

<img src="/img/diagram.png"/>

### Explaination:

During testing, i discovered a powerful technique to significantly boost the efficiency of domain scanning with Nuclei!

🚀 **Scanning Multiple Domains Simultaneously**:*
Nuclei can test an impressive 85 domains from a single <domain.txt> file at once!

💡 **Why This Matters**: Kali Linux has a tendency to terminate jobs after 12 hours of continuous execution in the ZSH shell. This limitation affects performance, especially when dealing with large numbers of domains.

🤔 **The Challenge**: Suppose you have 232,566 domains in your file. After 12 hours, Kali Linux will kill the job, allowing you to test only 85 domains each time. This process becomes extremely time-consuming!

🛠️ **The Solution**: By splitting the domains into multiple files and utilizing parallel processing, we can dramatically speed up the scanning process!

📊 **How It Works**:
1. This script (nuke-chunk.sh) splits the domains by 85 (232,566 ÷ 85 = 2,731 files)
2. Sends the split files to the chunks directory
3. Uses the `parallel` command to execute the Nuclei command on each file simultaneously

🎯 **Optimized Command**:

```
parallel -j 1 "nuclei -l "chunks/chunk_1.txt" -tags cve -c 85 -rl 85 -bs 85 -project -stream -timeout 3 -ss host-spray -mhe 85 >> combined_results.txt"
```
🔍 **Benefits**:
- Significantly reduces overall scanning time
- Maximizes utilization of computational resources
- Allows for efficient processing of large domain lists

🌟 **Conclusion**: By implementing this optimization technique, you can transform your domain scanning workflow, enabling faster and more efficient vulnerability assessments!

👍 **Try It Out**: Implement this script in your Nuclei setup and experience the power of parallel processing for yourself!
<hr>

#### contact

#### support:
If you find this tool helpful, please consider supporting my work, Your support helps me continue developing and maintaining open-source tools like ereplace.
<p align="center"><a href="https://buymeacoffee.com/locabomartin"><img  src="https://img.shields.io/badge/Buy%20Me%20a%20Coffee-ffdd00?style=for-the-badge&logo=buy-me-a-coffee&logoColor=black"/></a></p>
