
data_pack_object_align.x64:	file format elf64-x86-64

Disassembly of section .text:

<sum>:
               	movq	(%rip), %rax            # <addr>
		R_X86_64_PC32	.data+0xffc
               	movq	(%rip), %rcx            # <addr>
		R_X86_64_PC32	.data+0x1ffc
               	addq	%rcx, %rax
               	movq	(%rip), %rcx            # <addr>
		R_X86_64_PC32	.data+0x203c
               	addq	%rcx, %rax
               	movq	(%rip), %rcx            # <addr>
		R_X86_64_PC32	.bss-0x4
               	addq	%rcx, %rax
               	retq

<cache_addr>:
               	leaq	(%rip), %rax            # <addr>
		R_X86_64_PC32	.data+0x1ffc
               	retq
