
vtable_back_to_back_4arg.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<g_init>:
               	leaq	<rip>, %rax
               	movq	%rax, (%rdi)
               	leaq	(%rdx,%rcx), %rax
               	movl	%eax, 0x8(%rdi)
               	xorq	%rax, %rax
               	retq

<g_generate>:
               	movq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movslq	0x8(%rdi), %rax
               	addq	$0x64, %rax
               	movl	%eax, (%rsi)
               	movq	%rcx, %rax
               	retq

<driver>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	-0x10(%rbp), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x1, %ebx
               	movl	$0x64, %ecx
               	movq	%rbx, %rdx
               	callq	*%rax
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rax
               	movq	0x8(%rax), %rax
               	leaq	-0x10(%rbp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movq	%rbx, %rdx
               	callq	*%rax
               	movslq	-0x40(%rbp), %rax
               	movq	(%rsp), %rbx
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	popq	%rbp
               	jmp	<addr>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
