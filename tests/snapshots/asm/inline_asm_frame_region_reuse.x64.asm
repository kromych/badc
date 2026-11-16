
inline_asm_frame_region_reuse.x64:	file format elf64-x86-64

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

<main>:
               	xorl	%eax, %eax
               	incq	%rax
               	incq	%rax
               	incq	%rax
               	incq	%rax
               	incq	%rax
               	incq	%rax
               	incq	%rax
               	incq	%rax
               	xorl	%ecx, %ecx
               	movl	$0x1, %edx
               	cmpq	$0x8, %rax
               	movq	%rdx, %rax
               	cmoveq	%rcx, %rax
               	retq
