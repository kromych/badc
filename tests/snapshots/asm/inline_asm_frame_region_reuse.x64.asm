
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	xorq	%rax, %rax
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	movq	-0x8(%rbp), %rdx
               	incq	%rdx
               	movq	%rdx, -0x8(%rbp)
               	movq	-0x8(%rbp), %rcx
               	incq	%rcx
               	movq	%rcx, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	movq	-0x8(%rbp), %rdx
               	incq	%rdx
               	movq	%rdx, -0x8(%rbp)
               	movq	-0x8(%rbp), %rcx
               	incq	%rcx
               	movq	%rcx, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	movq	-0x8(%rbp), %rdx
               	incq	%rdx
               	movq	%rdx, -0x8(%rbp)
               	movq	-0x8(%rbp), %rcx
               	incq	%rcx
               	movq	%rcx, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	movq	-0x8(%rbp), %rdx
               	incq	%rdx
               	movq	%rdx, -0x8(%rbp)
               	movq	-0x8(%rbp), %rcx
               	incq	%rcx
               	cmpq	$0x8, %rcx
               	jne	<addr>
               	movslq	%eax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
