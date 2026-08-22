
global_struct_return_indirect.x64:	file format elf64-x86-64

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

<get_global>:
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movzbq	0x10(%rcx), %rdx
               	movb	%dl, 0x10(%rax)
               	movzbq	0x11(%rcx), %rdx
               	movb	%dl, 0x11(%rax)
               	movzbq	0x12(%rcx), %rdx
               	movb	%dl, 0x12(%rax)
               	movzbq	0x13(%rcx), %rdx
               	movb	%dl, 0x13(%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-0x48(%rbp), %rbx
               	movq	%rbx, %rdi
               	callq	<addr>
               	leaq	-0x60(%rbp), %rax
               	pushq	%rcx
               	movq	(%rbx), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rbx), %rcx
               	movq	%rcx, 0x8(%rax)
               	movzbq	0x10(%rbx), %rcx
               	movb	%cl, 0x10(%rax)
               	movzbq	0x11(%rbx), %rcx
               	movb	%cl, 0x11(%rax)
               	movzbq	0x12(%rbx), %rcx
               	movb	%cl, 0x12(%rax)
               	movzbq	0x13(%rbx), %rcx
               	movb	%cl, 0x13(%rax)
               	popq	%rcx
               	movq	%rax, %rcx
               	movl	(%rax), %ecx
               	xorq	$0x1, %rcx
               	movl	%ecx, %ecx
               	movl	$0x1, %edx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movslq	0x4(%rax), %rcx
               	cmpq	$0x2, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movslq	0x10(%rax), %rax
               	cmpq	$0x5, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	(%rsp), %rbx
               	movq	%rdx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rbx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movl	(%rbx), %ebx
               	leaq	-0x18(%rbp), %rdi
               	callq	<addr>
               	leaq	-0x18(%rbp), %rax
               	movslq	0x10(%rax), %rax
               	addq	%rbx, %rax
               	movl	%eax, %eax
               	movslq	%eax, %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
