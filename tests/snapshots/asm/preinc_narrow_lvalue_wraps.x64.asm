
preinc_narrow_lvalue_wraps.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0xff, %eax
               	movb	%al, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	xorq	%rax, %rax
               	movzbq	(%rcx), %rdx
               	incq	%rdx
               	movb	%dl, (%rcx)
               	movzbq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x1, %ecx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movzbq	-0x8(%rbp), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	%rax, %rbx
               	orq	$0x0, %rbx
               	movslq	%ebx, %rsi
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%ebx, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
