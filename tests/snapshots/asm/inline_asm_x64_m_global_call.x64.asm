
inline_asm_x64_m_global_call.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<forty>:
               	movl	$0x28, %eax
               	retq

<two>:
               	movl	$0x2, %eax
               	retq

<main>:
               	callq	*<rip>
               	movq	%rax, %rcx
               	leaq	<rip>, %rax
               	leaq	-<rip>, %rdx       # <addr>
               	movq	%rdx, 0x8(%rax)
               	callq	*<rip>
               	addq	%rcx, %rax
               	retq
