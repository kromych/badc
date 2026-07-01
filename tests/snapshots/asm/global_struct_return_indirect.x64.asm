
global_struct_return_indirect.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

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
               	subq	$0xf0, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-0x80(%rbp), %rdi
               	callq	<addr>
               	leaq	-0x80(%rbp), %rax
               	leaq	-0x18(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	movzbq	0x10(%rax), %rdx
               	movb	%dl, 0x10(%rcx)
               	movzbq	0x11(%rax), %rdx
               	movb	%dl, 0x11(%rcx)
               	movzbq	0x12(%rax), %rdx
               	movb	%dl, 0x12(%rcx)
               	movzbq	0x13(%rax), %rdx
               	movb	%dl, 0x13(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x18(%rbp), %rax
               	movl	(%rax), %eax
               	xorq	$0x1, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %ebx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x18(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x2, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	leaq	-0x18(%rbp), %rax
               	movslq	0x10(%rax), %rax
               	cmpq	$0x5, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xb0(%rbp), %rdi
               	callq	<addr>
               	leaq	-0xb0(%rbp), %rax
               	movl	(%rax), %ebx
               	leaq	-0xd0(%rbp), %rdi
               	callq	<addr>
               	leaq	-0xd0(%rbp), %rax
               	movslq	0x10(%rax), %rax
               	addq	%rbx, %rax
               	movl	%eax, %eax
               	movslq	%eax, %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
