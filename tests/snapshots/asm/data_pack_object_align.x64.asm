
data_pack_object_align.x64:	file format elf64-x86-64

Disassembly of section .text:

<sum>:
               	leaq	(%rip), %rax            # <addr>
		R_X86_64_PC32	.data+0xffc
               	movq	(%rax), %rax
               	leaq	(%rip), %rcx            # <addr>
		R_X86_64_PC32	.data+0x1ffc
               	movq	(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	(%rip), %rcx            # <addr>
		R_X86_64_PC32	.data+0x203c
               	movq	(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	(%rip), %rcx            # <addr>
		R_X86_64_PC32	.bss-0x4
               	movq	(%rcx), %rcx
               	addq	%rcx, %rax
               	retq

<cache_addr>:
               	leaq	(%rip), %rax            # <addr>
		R_X86_64_PC32	.data+0x1ffc
               	retq
