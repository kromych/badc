
struct_arg_by_stack.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<take>:
               	popq	%r10
               	subq	$0x30, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%r13, (%rsp)
               	movq	%rsi, -0x30(%rbp)
               	movq	%rdx, -0x28(%rbp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, -0x20(%rbp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, -0x18(%rbp)
               	movq	0x50(%rbp), %r10
               	movq	%r10, -0x10(%rbp)
               	movq	0x58(%rbp), %r10
               	movq	%r10, -0x8(%rbp)
               	movslq	%edi, %rdi
               	leaq	<rip>, %rax
               	movq	%rdi, (%rax)
               	leaq	<rip>, %rax
               	leaq	-0x20(%rbp), %rcx
               	movq	(%rcx), %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	leaq	-0x20(%rbp), %rcx
               	movq	0x8(%rcx), %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	leaq	-0x20(%rbp), %rcx
               	movq	0x10(%rcx), %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	leaq	-0x20(%rbp), %rcx
               	movq	0x18(%rcx), %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	leaq	-0x30(%rbp), %rcx
               	movq	(%rcx), %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	leaq	-0x30(%rbp), %rcx
               	movq	0x8(%rcx), %rcx
               	movq	%rcx, (%rax)
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x30, %rsp
               	pushq	%r11
               	retq

<mutate>:
               	popq	%r10
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%r13, (%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, -0x20(%rbp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, -0x18(%rbp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, -0x10(%rbp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, -0x8(%rbp)
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rcx
               	addq	$0x3e8, %rcx            # imm = 0x3E8
               	movq	%rcx, (%rax)
               	leaq	-0x20(%rbp), %rax
               	movq	0x18(%rax), %rcx
               	decq	%rcx
               	movq	%rcx, 0x18(%rax)
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rax
               	leaq	-0x20(%rbp), %rcx
               	movq	0x8(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	-0x20(%rbp), %rcx
               	movq	0x10(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	-0x20(%rbp), %rcx
               	movq	0x18(%rcx), %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	leaq	-0x20(%rbp), %rax
               	movl	$0xb, %ecx
               	movq	%rcx, (%rax)
               	leaq	-0x20(%rbp), %rax
               	movl	$0x16, %ecx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x20(%rbp), %rax
               	movl	$0x21, %ecx
               	movq	%rcx, 0x10(%rax)
               	leaq	-0x20(%rbp), %rax
               	movl	$0x2c, %ecx
               	movq	%rcx, 0x18(%rax)
               	leaq	-0x30(%rbp), %rax
               	movl	$0x5, %ecx
               	movq	%rcx, (%rax)
               	leaq	-0x30(%rbp), %rax
               	movl	$0x6, %ecx
               	movq	%rcx, 0x8(%rax)
               	movl	$0x7, %edi
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x30(%rbp), %rdx
               	subq	$0x20, %rsp
               	movq	%rsi, %r10
               	movq	(%r10), %r13
               	movq	%r13, (%rsp)
               	movq	0x8(%r10), %r13
               	movq	%r13, 0x8(%rsp)
               	movq	0x10(%r10), %r13
               	movq	%r13, 0x10(%rsp)
               	movq	0x18(%r10), %r13
               	movq	%r13, 0x18(%rsp)
               	movq	%rdx, %rsi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0xb, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %ebx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x16, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	movl	$0x1, %r12d
               	testq	%rbx, %rbx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x21, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%r12b
               	movzbq	%r12b, %r12
               	testq	%r12, %r12
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2c, %rax
               	setne	%r12b
               	movzbq	%r12b, %r12
               	testq	%r12, %r12
               	je	<addr>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x5, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x6, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rdi
               	subq	$0x20, %rsp
               	movq	%rdi, %r10
               	movq	(%r10), %r13
               	movq	%r13, (%rsp)
               	movq	0x8(%r10), %r13
               	movq	%r13, 0x8(%rsp)
               	movq	0x10(%r10), %r13
               	movq	%r13, 0x10(%rsp)
               	movq	0x18(%r10), %r13
               	movq	%r13, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	cmpq	$0x455, %rax            # imm = 0x455
               	je	<addr>
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	$0xb, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x20(%rbp), %rax
               	movq	0x18(%rax), %rax
               	cmpq	$0x2c, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, (%rax)
