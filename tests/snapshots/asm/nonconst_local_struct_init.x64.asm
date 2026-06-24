
nonconst_local_struct_init.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<identity>:
               	movq	%rdi, %rax
               	movslq	%eax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x110, %rsp            # imm = 0x110
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movl	$0x2a, %ebx
               	movl	$0x63, %r12d
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	leaq	-0x18(%rbp), %rax
               	movl	%ebx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	%r12d, 0x4(%rax)
               	leaq	-0x18(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x2a, %rax
               	setne	%r13b
               	movzbq	%r13b, %r13
               	testq	%r13, %r13
               	jne	<addr>
               	leaq	-0x18(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x63, %rax
               	setne	%r13b
               	movzbq	%r13b, %r13
               	testq	%r13, %r13
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	-0x18(%rbp), %rax
               	movslq	(%rax), %rsi
               	leaq	-0x18(%rbp), %rax
               	movslq	0x4(%rax), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	movl	$0x7, %eax
               	leaq	-0x20(%rbp), %rcx
               	movl	%eax, (%rcx)
               	leaq	-0x20(%rbp), %rax
               	movl	%r12d, 0x4(%rax)
               	leaq	-0x20(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x7, %rax
               	setne	%r13b
               	movzbq	%r13b, %r13
               	testq	%r13, %r13
               	jne	<addr>
               	leaq	-0x20(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x63, %rax
               	setne	%r13b
               	movzbq	%r13b, %r13
               	testq	%r13, %r13
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	-0x20(%rbp), %rax
               	movslq	(%rax), %rsi
               	leaq	-0x20(%rbp), %rax
               	movslq	0x4(%rax), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	movl	$0xb, %edi
               	callq	<addr>
               	leaq	-0x28(%rbp), %rcx
               	movl	%eax, (%rcx)
               	movl	$0x16, %edi
               	callq	<addr>
               	leaq	-0x28(%rbp), %rcx
               	movl	%eax, 0x4(%rcx)
               	leaq	-0x28(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0xb, %rax
               	setne	%r13b
               	movzbq	%r13b, %r13
               	testq	%r13, %r13
               	jne	<addr>
               	leaq	-0x28(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x16, %rax
               	setne	%r13b
               	movzbq	%r13b, %r13
               	testq	%r13, %r13
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	-0x28(%rbp), %rax
               	movslq	(%rax), %rsi
               	leaq	-0x28(%rbp), %rax
               	movslq	0x4(%rax), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	leaq	-0x38(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movzbq	0x8(%rcx), %rdx
               	movb	%dl, 0x8(%rax)
               	movzbq	0x9(%rcx), %rdx
               	movb	%dl, 0x9(%rax)
               	movzbq	0xa(%rcx), %rdx
               	movb	%dl, 0xa(%rax)
               	movzbq	0xb(%rcx), %rdx
               	movb	%dl, 0xb(%rax)
               	popq	%rdx
               	leaq	-0x38(%rbp), %rax
               	movl	%ebx, (%rax)
               	leaq	-0x38(%rbp), %rax
               	movl	%r12d, 0x8(%rax)
               	leaq	-0x38(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x2a, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %r13d
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x38(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%r13b
               	movzbq	%r13b, %r13
               	testq	%r13, %r13
               	jne	<addr>
               	leaq	-0x38(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0x63, %rax
               	setne	%r13b
               	movzbq	%r13b, %r13
               	testq	%r13, %r13
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	-0x38(%rbp), %rax
               	movslq	(%rax), %rsi
               	leaq	-0x38(%rbp), %rax
               	movslq	0x4(%rax), %rdx
               	leaq	-0x38(%rbp), %rax
               	movslq	0x8(%rax), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	leaq	-0x48(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movzbq	0x8(%rcx), %rdx
               	movb	%dl, 0x8(%rax)
               	movzbq	0x9(%rcx), %rdx
               	movb	%dl, 0x9(%rax)
               	movzbq	0xa(%rcx), %rdx
               	movb	%dl, 0xa(%rax)
               	movzbq	0xb(%rcx), %rdx
               	movb	%dl, 0xb(%rax)
               	popq	%rdx
               	leaq	-0x48(%rbp), %rax
               	movl	%r12d, 0x8(%rax)
               	leaq	-0x48(%rbp), %rax
               	movl	%ebx, (%rax)
               	leaq	-0x48(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x2a, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %r13d
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x48(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%r13b
               	movzbq	%r13b, %r13
               	testq	%r13, %r13
               	jne	<addr>
               	leaq	-0x48(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0x63, %rax
               	setne	%r13b
               	movzbq	%r13b, %r13
               	testq	%r13, %r13
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	-0x48(%rbp), %rax
               	movslq	(%rax), %rsi
               	leaq	-0x48(%rbp), %rax
               	movslq	0x4(%rax), %rdx
               	leaq	-0x48(%rbp), %rax
               	movslq	0x8(%rax), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movzbq	0x8(%rcx), %rdx
               	movb	%dl, 0x8(%rax)
               	movzbq	0x9(%rcx), %rdx
               	movb	%dl, 0x9(%rax)
               	movzbq	0xa(%rcx), %rdx
               	movb	%dl, 0xa(%rax)
               	movzbq	0xb(%rcx), %rdx
               	movb	%dl, 0xb(%rax)
               	popq	%rdx
               	leaq	-0x58(%rbp), %rax
               	movl	%ebx, (%rax)
               	leaq	-0x58(%rbp), %rax
               	movl	%r12d, 0x8(%rax)
               	leaq	-0x58(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x2a, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %ebx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x58(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	leaq	-0x58(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0x63, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	-0x58(%rbp), %rax
               	movslq	(%rax), %rsi
               	leaq	-0x58(%rbp), %rax
               	movslq	0x4(%rax), %rdx
               	leaq	-0x58(%rbp), %rax
               	movslq	0x8(%rax), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	leaq	-0x68(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movzbq	0x8(%rcx), %rdx
               	movb	%dl, 0x8(%rax)
               	movzbq	0x9(%rcx), %rdx
               	movb	%dl, 0x9(%rax)
               	movzbq	0xa(%rcx), %rdx
               	movb	%dl, 0xa(%rax)
               	movzbq	0xb(%rcx), %rdx
               	movb	%dl, 0xb(%rax)
               	popq	%rdx
               	leaq	-0x78(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movzbq	0x8(%rcx), %rdx
               	movb	%dl, 0x8(%rax)
               	movzbq	0x9(%rcx), %rdx
               	movb	%dl, 0x9(%rax)
               	movzbq	0xa(%rcx), %rdx
               	movb	%dl, 0xa(%rax)
               	movzbq	0xb(%rcx), %rdx
               	movb	%dl, 0xb(%rax)
               	popq	%rdx
               	leaq	-0x78(%rbp), %rax
               	movl	%r12d, 0x4(%rax)
               	leaq	-0x78(%rbp), %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %ebx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x78(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x63, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	leaq	-0x78(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	testq	%rax, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	-0x78(%rbp), %rax
               	movslq	(%rax), %rsi
               	leaq	-0x78(%rbp), %rax
               	movslq	0x4(%rax), %rdx
               	leaq	-0x78(%rbp), %rax
               	movslq	0x8(%rax), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
