
fn_type_typedef_field.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x220, %esi            # imm = 0x220
               	callq	<addr>
               	ud2

<make>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%r13, (%rsp)
               	movslq	%edi, %rdi
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	movq	0x8(%rcx), %r11
               	movq	%r11, 0x8(%rax)
               	popq	%r11
               	leaq	-0x10(%rbp), %rax
               	movq	%rdi, (%rax)
               	movq	%rdi, %rax
               	shlq	$0x1, %rax
               	movslq	%eax, %rax
               	leaq	-0x10(%rbp), %rcx
               	movq	%rax, 0x8(%rcx)
               	leaq	-0x10(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xb0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	leaq	-0x8(%rbp), %rax
               	leaq	-<rip>, %rbx       # <addr>
               	movq	%rbx, (%rax)
               	leaq	-0x20(%rbp), %r12
               	movl	$0x7, %edi
               	movq	%rbx, %r11
               	callq	*%r11
               	movq	%rax, -0x60(%rbp)
               	movq	%rdx, -0x58(%rbp)
               	leaq	-0x60(%rbp), %rax
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%r12)
               	movq	0x8(%rax), %r11
               	movq	%r11, 0x8(%r12)
               	popq	%r11
               	movq	%r12, %rax
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	$0x7, %rax
               	setne	%r12b
               	movzbq	%r12b, %r12
               	testq	%r12, %r12
               	jne	<addr>
               	leaq	-0x20(%rbp), %rax
               	movq	0x8(%rax), %rax
               	cmpq	$0xe, %rax
               	setne	%r12b
               	movzbq	%r12b, %r12
               	testq	%r12, %r12
               	je	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movq	%rbx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %rax
               	movl	$0x5, %edi
               	movq	%rax, %r11
               	callq	*%r11
               	movq	%rax, -0x80(%rbp)
               	movq	%rdx, -0x78(%rbp)
               	leaq	-0x80(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	$0x5, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %rax
               	movl	$0x5, %edi
               	movq	%rax, %r11
               	callq	*%r11
               	movq	%rax, -0x90(%rbp)
               	movq	%rdx, -0x88(%rbp)
               	leaq	-0x90(%rbp), %rax
               	movq	0x8(%rax), %rax
               	cmpq	$0xa, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
