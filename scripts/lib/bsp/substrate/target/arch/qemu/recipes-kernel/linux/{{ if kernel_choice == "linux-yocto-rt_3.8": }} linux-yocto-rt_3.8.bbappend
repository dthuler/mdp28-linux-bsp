FILESEXTRAPATHS_prepend_{{=machine}} := "${THISDIR}/files:"

PR := "${PR}.1"

COMPATIBLE_MACHINE_{{=machine}} = "{{=machine}}"
{{ input type:"boolean" name:"need_new_kbranch" prio:"20" msg:"Do you need a new machine branch for this BSP (the alternative is to re-use an existing branch)? [y/n]" default:"y" }}

{{ if need_new_kbranch == "y" and qemuarch == "arm": }}
{{ input type:"choicelist" name:"new_kbranch" nameappend:"arm" gen:"bsp.kernel.all_branches" branches_base:"standard/preempt-rt" prio:"20" msg:"Please choose a machine branch to base this BSP on:" default:"standard/preempt-rt/base" }}

{{ if need_new_kbranch == "n" and qemuarch == "arm": }}
{{ input type:"choicelist" name:"existing_kbranch" nameappend:"arm" gen:"bsp.kernel.all_branches" branches_base:"standard/preempt-rt" prio:"20" msg:"Please choose a machine branch to base this BSP on:" default:"standard/preempt-rt/base" }}

{{ if need_new_kbranch == "y" and qemuarch == "powerpc": }}
{{ input type:"choicelist" name:"new_kbranch" nameappend:"powerpc" gen:"bsp.kernel.all_branches" branches_base:"standard/preempt-rt" prio:"20" msg:"Please choose a machine branch to base this BSP on:" default:"standard/preempt-rt/base" }}

{{ if need_new_kbranch == "n" and qemuarch == "powerpc": }}
{{ input type:"choicelist" name:"existing_kbranch" nameappend:"powerpc" gen:"bsp.kernel.all_branches" branches_base:"standard/preempt-rt" prio:"20" msg:"Please choose a machine branch to base this BSP on:" default:"standard/preempt-rt/qemu-ppc32" }}

{{ if need_new_kbranch == "y" and qemuarch == "i386": }}
{{ input type:"choicelist" name:"new_kbranch" nameappend:"i386" gen:"bsp.kernel.all_branches" branches_base:"standard/preempt-rt" prio:"20" msg:"Please choose a machine branch to base this BSP on:" default:"standard/preempt-rt/base" }}

{{ if need_new_kbranch == "n" and qemuarch == "i386": }}
{{ input type:"choicelist" name:"existing_kbranch" nameappend:"i386" gen:"bsp.kernel.all_branches" branches_base:"standard/preempt-rt" prio:"20" msg:"Please choose a machine branch to base this BSP on:" default:"standard/preempt-rt/base" }}

{{ if need_new_kbranch == "y" and qemuarch == "x86_64": }}
{{ input type:"choicelist" name:"new_kbranch" nameappend:"x86_64" gen:"bsp.kernel.all_branches" branches_base:"standard/preempt-rt" prio:"20" msg:"Please choose a machine branch to base this BSP on:" default:"standard/preempt-rt/base" }}

{{ if need_new_kbranch == "n" and qemuarch == "x86_64": }}
{{ input type:"choicelist" name:"existing_kbranch" nameappend:"x86_64" gen:"bsp.kernel.all_branches" branches_base:"standard/preempt-rt" prio:"20" msg:"Please choose a machine branch to base this BSP on:" default:"standard/preempt-rt/base" }}

{{ if need_new_kbranch == "y" and qemuarch == "mips": }}
{{ input type:"choicelist" name:"new_kbranch" nameappend:"mips" gen:"bsp.kernel.all_branches" branches_base:"standard/preempt-rt" prio:"20" msg:"Please choose a machine branch to base this BSP on:" default:"standard/preempt-rt/base" }}

{{ if need_new_kbranch == "n" and qemuarch == "mips": }}
{{ input type:"choicelist" name:"existing_kbranch" nameappend:"mips" gen:"bsp.kernel.all_branches" branches_base:"standard/preempt-rt" prio:"20" msg:"Please choose a machine branch to base this BSP on:" default:"standard/preempt-rt/base" }}

{{ if need_new_kbranch == "n": }}
KBRANCH_{{=machine}}  = "{{=existing_kbranch}}"

{{ input type:"boolean" name:"smp" prio:"30" msg:"Do you need SMP support? (y/n)" default:"y"}}
{{ if smp == "y": }}
KERNEL_FEATURES_append_{{=machine}} += " cfg/smp.scc"

SRC_URI += "file://{{=machine}}-preempt-rt.scc \
            file://{{=machine}}-user-config.cfg \
            file://{{=machine}}-user-patches.scc \
            file://{{=machine}}-user-features.scc \
           "

# uncomment and replace these SRCREVs with the real commit ids once you've had
# the appropriate changes committed to the upstream linux-yocto repo
#SRCREV_machine_pn-linux-yocto-rt_{{=machine}} ?= "f35992f80c81dc5fa1a97165dfd5cbb84661f7cb"
#SRCREV_meta_pn-linux-yocto-rt_{{=machine}} ?= "1b534b2f8bbe9b8a773268cfa30a4850346f6f5f"
#LINUX_VERSION = "3.8.4"
