
indirect_struct_return_outptr.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x220, %esi            # imm = 0x220
               	callq	<addr>
               	ud2

<make_big>:
               	popq	%r10
               	subq	$0x20, %rsp
               	movq	%rdi, (%rsp)
               	movq	%rsi, 0x10(%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	leaq	-0x28(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	movq	0x8(%rcx), %r11
               	movq	%r11, 0x8(%rax)
               	movq	0x10(%rcx), %r11
               	movq	%r11, 0x10(%rax)
               	movq	0x18(%rcx), %r11
               	movq	%r11, 0x18(%rax)
               	movq	0x20(%rcx), %r11
               	movq	%r11, 0x20(%rax)
               	popq	%r11
               	movslq	0x20(%rbp), %rax
               	leaq	-0x28(%rbp), %rcx
               	movq	%rax, (%rcx)
               	movslq	0x20(%rbp), %rax
               	incq	%rax
               	movslq	%eax, %rax
               	leaq	-0x28(%rbp), %rcx
               	movq	%rax, 0x8(%rcx)
               	movslq	0x20(%rbp), %rax
               	addq	$0x2, %rax
               	movslq	%eax, %rax
               	leaq	-0x28(%rbp), %rcx
               	movq	%rax, 0x10(%rcx)
               	movslq	0x20(%rbp), %rax
               	addq	$0x3, %rax
               	movslq	%eax, %rax
               	leaq	-0x28(%rbp), %rcx
               	movq	%rax, 0x18(%rcx)
               	movslq	0x20(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	%eax, %rax
               	leaq	-0x28(%rbp), %rcx
               	movq	%rax, 0x20(%rcx)
               	movq	0x10(%rbp), %rax
               	leaq	-0x28(%rbp), %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	movq	0x8(%rcx), %r11
               	movq	%r11, 0x8(%rax)
               	movq	0x10(%rcx), %r11
               	movq	%r11, 0x10(%rax)
               	movq	0x18(%rcx), %r11
               	movq	%r11, 0x18(%rax)
               	movq	0x20(%rcx), %r11
               	movq	%r11, 0x20(%rax)
               	popq	%r11
               	movq	%rax, %rcx
               	addq	$0x30, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq

<make_pair>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
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
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x120, %rsp            # imm = 0x120
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	leaq	-<rip>, %rbx      # <addr>
               	leaq	-<rip>, %r12       # <addr>
               	movl	$0xa, %esi
               	leaq	-0x78(%rbp), %rdi
               	movq	%rbx, %r11
               	callq	*%r11
               	leaq	-0x78(%rbp), %rax
               	leaq	-0x38(%rbp), %rcx
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%rcx)
               	movq	0x8(%rax), %r11
               	movq	%r11, 0x8(%rcx)
               	movq	0x10(%rax), %r11
               	movq	%r11, 0x10(%rcx)
               	movq	0x18(%rax), %r11
               	movq	%r11, 0x18(%rcx)
               	movq	0x20(%rax), %r11
               	movq	%r11, 0x20(%rcx)
               	popq	%r11
               	movq	%rcx, %rax
               	leaq	-0x38(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	$0xa, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %r14d
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x38(%rbp), %rax
               	movq	0x10(%rax), %rax
               	cmpq	$0xc, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%r14b
               	movzbq	%r14b, %r14
               	testq	%r14, %r14
               	jne	<addr>
               	leaq	-0x38(%rbp), %rax
               	movq	0x20(%rax), %rax
               	cmpq	$0xe, %rax
               	setne	%r14b
               	movzbq	%r14b, %r14
               	testq	%r14, %r14
               	je	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	movl	$0x7, %edi
               	movq	%r12, %r11
               	callq	*%r11
               	movq	%rax, -0xa0(%rbp)
               	movq	%rdx, -0x98(%rbp)
               	leaq	-0xa0(%rbp), %rax
               	leaq	-0x48(%rbp), %rcx
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%rcx)
               	movq	0x8(%rax), %r11
               	movq	%r11, 0x8(%rcx)
               	popq	%r11
               	movq	%rcx, %rax
               	leaq	-0x48(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	$0x7, %rax
               	setne	%r14b
               	movzbq	%r14b, %r14
               	testq	%r14, %r14
               	jne	<addr>
               	leaq	-0x48(%rbp), %rax
               	movq	0x8(%rax), %rax
               	cmpq	$0xe, %rax
               	setne	%r14b
               	movzbq	%r14b, %r14
               	testq	%r14, %r14
               	je	<addr>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	movl	$0x3, %esi
               	leaq	-0xd0(%rbp), %rdi
               	movq	%rbx, %r11
               	callq	*%r11
               	leaq	-0xd0(%rbp), %rax
               	movq	0x20(%rax), %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	movl	$0x5, %ebx
               	movq	%r12, %r11
               	movq	%rbx, %rdi
               	callq	*%r11
               	movq	%rax, -0xe8(%rbp)
               	movq	%rdx, -0xe0(%rbp)
               	leaq	-0xe8(%rbp), %rax
               	movq	(%rax), %r14
               	movq	%r12, %r11
               	movq	%rbx, %rdi
               	callq	*%r11
               	movq	%rax, -0xf8(%rbp)
               	movq	%rdx, -0xf0(%rbp)
               	leaq	-0xf8(%rbp), %rax
               	movq	0x8(%rax), %rax
               	addq	%r14, %rax
               	cmpq	$0xf, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
