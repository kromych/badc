
inline_asm_goto_multiret.x64:	file format elf64-x86-64

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
               	jmp	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	nop
               	jmp	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	leaq	-0x10(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	cmpq	$0xa, %rcx
               	jne	<addr>
               	cmpq	$0x16, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	cmpq	$0xa, %rcx
               	jne	<addr>
               	movq	0x8(%rax), %rax
               	cmpq	$0x14, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movl	$0x2a, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	0x8(%rax), %rcx
               	addq	$0x2, %rcx
               	movq	%rcx, 0x8(%rax)
               	jmp	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
