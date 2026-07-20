
int128_cmp.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x2c0, %rsp            # imm = 0x2C0
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rsi
               	leaq	-0x80(%rbp), %rcx
               	movq	%rsi, (%rcx)
               	xorq	%rax, %rax
               	movq	%rax, 0x8(%rcx)
               	leaq	-0x90(%rbp), %rcx
               	movq	%rax, (%rcx)
               	movq	%rsi, 0x8(%rcx)
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rcx
               	movq	%rax, %r8
               	orq	%rcx, %r8
               	orq	%rax, %rsi
               	leaq	-0xa0(%rbp), %rcx
               	movq	%r8, (%rcx)
               	movq	%rsi, 0x8(%rcx)
               	leaq	-0x10(%rbp), %rsi
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movq	%rsi, %rcx
               	movq	(%rdi), %rsi
               	leaq	-0xb0(%rbp), %rcx
               	movq	%rsi, (%rcx)
               	movq	%rax, 0x8(%rcx)
               	leaq	-0xc0(%rbp), %rcx
               	movq	%rax, (%rcx)
               	movq	%rsi, 0x8(%rcx)
               	movq	(%rdx), %rdi
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r8
               	addq	%r8, %rdi
               	orq	%rax, %rdi
               	movq	%rsi, %r8
               	orq	%rax, %r8
               	leaq	-0xd0(%rbp), %rsi
               	movq	%rdi, (%rsi)
               	movq	%r8, 0x8(%rsi)
               	leaq	-0x20(%rbp), %rdi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rsi
               	movq	(%rcx), %rdi
               	leaq	-0xe0(%rbp), %rsi
               	movq	%rdi, (%rsi)
               	movq	%rax, 0x8(%rsi)
               	testq	%rdi, %rdi
               	seta	%sil
               	movzbq	%sil, %rsi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movq	%rax, %r8
               	subq	%rax, %r8
               	subq	%rsi, %r8
               	leaq	-0xf0(%rbp), %rsi
               	movq	%rdi, (%rsi)
               	movq	%r8, 0x8(%rsi)
               	leaq	-0x30(%rbp), %rdi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rsi
               	movq	(%rcx), %rdi
               	leaq	-0x100(%rbp), %rsi
               	movq	%rdi, (%rsi)
               	movq	%rax, 0x8(%rsi)
               	shlq	$0x3f, %rdi
               	leaq	-0x110(%rbp), %rsi
               	movq	%rax, (%rsi)
               	movq	%rdi, 0x8(%rsi)
               	leaq	-0x40(%rbp), %rdi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rsi
               	movq	(%rcx), %rdi
               	leaq	-0x120(%rbp), %rsi
               	movq	%rdi, (%rsi)
               	movq	%rax, 0x8(%rsi)
               	leaq	-0x50(%rbp), %rax
               	pushq	%rcx
               	movq	(%rsi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rdi
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %r8
               	movq	0x8(%rax), %rax
               	xorq	%r8, %rsi
               	xorq	%rdi, %rax
               	orq	%rsi, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rdi
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %r8
               	movq	0x8(%rax), %rax
               	xorq	%r8, %rsi
               	xorq	%rdi, %rax
               	orq	%rsi, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x2c0, %rsp            # imm = 0x2C0
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rdi
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %r8
               	movq	0x8(%rax), %rax
               	xorq	%r8, %rsi
               	xorq	%rdi, %rax
               	orq	%rsi, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rdi
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %r8
               	movq	0x8(%rax), %rax
               	xorq	%r8, %rsi
               	xorq	%rdi, %rax
               	orq	%rsi, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x2c0, %rsp            # imm = 0x2C0
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %r8
               	movq	0x8(%rax), %r9
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rbx
               	movq	0x8(%rax), %r12
               	movq	(%rcx), %rdi
               	leaq	-0x140(%rbp), %rax
               	movq	%rdi, (%rax)
               	xorq	%rsi, %rsi
               	movq	%rsi, 0x8(%rax)
               	shlq	$0x3f, %rdi
               	leaq	-0x150(%rbp), %rax
               	movq	%rsi, (%rax)
               	movq	%rdi, 0x8(%rax)
               	xorq	%rbx, %rsi
               	xorq	%r12, %rdi
               	leaq	-0x160(%rbp), %rax
               	movq	%rsi, (%rax)
               	movq	%rdi, 0x8(%rax)
               	movq	%r8, %rax
               	xorq	%rsi, %rax
               	movq	%r9, %rsi
               	xorq	%rdi, %rsi
               	orq	%rsi, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x2c0, %rsp            # imm = 0x2C0
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rdi
               	movq	0x8(%rax), %rsi
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %r8
               	movq	0x8(%rax), %rax
               	cmpq	%rax, %rsi
               	setb	%r9b
               	movzbq	%r9b, %r9
               	cmpq	%rax, %rsi
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	%r8, %rdi
               	setb	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	orq	%r9, %rax
               	testq	%rax, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	movl	$0x1, %eax
               	testq	%rsi, %rsi
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rdi
               	movq	0x8(%rax), %rsi
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %r8
               	movq	0x8(%rax), %rax
               	cmpq	%rsi, %rax
               	setb	%r9b
               	movzbq	%r9b, %r9
               	cmpq	%rsi, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	%rdi, %r8
               	setb	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	orq	%r9, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %esi
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rdi
               	movq	0x8(%rax), %rsi
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %r8
               	movq	0x8(%rax), %rax
               	cmpq	%rsi, %rax
               	setb	%r9b
               	movzbq	%r9b, %r9
               	cmpq	%rsi, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	%rdi, %r8
               	setb	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	orq	%r9, %rax
               	xorq	$0x1, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%sil
               	movzbq	%sil, %rsi
               	movl	$0x1, %edi
               	testq	%rsi, %rsi
               	jne	<addr>
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rdi
               	movq	0x8(%rax), %rsi
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %r8
               	movq	0x8(%rax), %rax
               	cmpq	%rax, %rsi
               	setb	%r9b
               	movzbq	%r9b, %r9
               	cmpq	%rax, %rsi
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	%r8, %rdi
               	setb	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	orq	%r9, %rax
               	xorq	$0x1, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%dil
               	movzbq	%dil, %rdi
               	movl	$0x1, %eax
               	testq	%rdi, %rdi
               	jne	<addr>
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rdi
               	movq	0x8(%rax), %rsi
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %r8
               	movq	0x8(%rax), %rax
               	cmpq	%rsi, %rax
               	setb	%r9b
               	movzbq	%r9b, %r9
               	cmpq	%rsi, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	%rdi, %r8
               	setb	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	orq	%r9, %rax
               	xorq	$0x1, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rdi
               	movq	0x8(%rax), %rsi
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %r8
               	movq	0x8(%rax), %rax
               	cmpq	%rax, %rsi
               	setb	%r9b
               	movzbq	%r9b, %r9
               	cmpq	%rax, %rsi
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	%r8, %rdi
               	setb	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	orq	%r9, %rax
               	xorq	$0x1, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x2c0, %rsp            # imm = 0x2C0
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rdi
               	movq	0x8(%rax), %rsi
               	leaq	-0x30(%rbp), %rax
               	movq	(%rax), %r8
               	movq	0x8(%rax), %rax
               	cmpq	%rax, %rsi
               	setb	%r9b
               	movzbq	%r9b, %r9
               	cmpq	%rax, %rsi
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	%r8, %rdi
               	setb	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	orq	%r9, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	(%rcx), %rsi
               	leaq	-0x1a0(%rbp), %rax
               	movq	%rsi, (%rax)
               	xorq	%rdi, %rdi
               	movq	%rdi, 0x8(%rax)
               	leaq	-0x1b0(%rbp), %rax
               	movq	%rdi, (%rax)
               	movq	%rsi, 0x8(%rax)
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %r8
               	movq	0x8(%rax), %rax
               	cmpq	%rax, %rsi
               	setb	%r9b
               	movzbq	%r9b, %r9
               	cmpq	%rax, %rsi
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	%r8, %rdi
               	setb	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	orq	%r9, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x2c0, %rsp            # imm = 0x2C0
               	popq	%rbp
               	retq
               	movq	(%rdx), %r8
               	leaq	-0x1c0(%rbp), %rsi
               	movq	%r8, (%rsi)
               	xorq	%rax, %rax
               	movq	%rax, 0x8(%rsi)
               	movq	(%rcx), %rdi
               	leaq	-0x1d0(%rbp), %rsi
               	movq	%rdi, (%rsi)
               	movq	%rax, 0x8(%rsi)
               	leaq	-0x1e0(%rbp), %rsi
               	movq	%rax, (%rsi)
               	movq	%rdi, 0x8(%rsi)
               	cmpq	%rdi, %rax
               	setb	%sil
               	movzbq	%sil, %rsi
               	cmpq	%rdi, %rax
               	sete	%dil
               	movzbq	%dil, %rdi
               	cmpq	%rax, %r8
               	setb	%al
               	movzbq	%al, %rax
               	andq	%rdi, %rax
               	orq	%rsi, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x2c0, %rsp            # imm = 0x2C0
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	movq	(%rax), %rdi
               	movq	0x8(%rax), %rsi
               	leaq	-0x50(%rbp), %rax
               	movq	(%rax), %r8
               	movq	0x8(%rax), %rax
               	cmpq	%rax, %rsi
               	setl	%r9b
               	movzbq	%r9b, %r9
               	cmpq	%rax, %rsi
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	%r8, %rdi
               	setb	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	orq	%r9, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movl	$0x1, %esi
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x30(%rbp), %rax
               	movq	(%rax), %rdi
               	movq	0x8(%rax), %rsi
               	leaq	-0x50(%rbp), %rax
               	movq	(%rax), %r8
               	movq	0x8(%rax), %rax
               	cmpq	%rsi, %rax
               	setl	%r9b
               	movzbq	%r9b, %r9
               	cmpq	%rsi, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	%rdi, %r8
               	setb	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	orq	%r9, %rax
               	testq	%rax, %rax
               	setne	%sil
               	movzbq	%sil, %rsi
               	movl	$0x1, %eax
               	testq	%rsi, %rsi
               	jne	<addr>
               	leaq	-0x40(%rbp), %rax
               	movq	(%rax), %rdi
               	movq	0x8(%rax), %rsi
               	leaq	-0x30(%rbp), %rax
               	movq	(%rax), %r8
               	movq	0x8(%rax), %rax
               	cmpq	%rax, %rsi
               	setl	%r9b
               	movzbq	%r9b, %r9
               	cmpq	%rax, %rsi
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	%r8, %rdi
               	setb	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	orq	%r9, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x40(%rbp), %rax
               	movq	(%rax), %rdi
               	movq	0x8(%rax), %rsi
               	leaq	-0x50(%rbp), %rax
               	movq	(%rax), %r8
               	movq	0x8(%rax), %rax
               	cmpq	%rax, %rsi
               	setl	%r9b
               	movzbq	%r9b, %r9
               	cmpq	%rax, %rsi
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	%r8, %rdi
               	setb	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	orq	%r9, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x2c0, %rsp            # imm = 0x2C0
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	movq	(%rax), %rdi
               	movq	0x8(%rax), %rsi
               	leaq	-0x40(%rbp), %rax
               	movq	(%rax), %r8
               	movq	0x8(%rax), %rax
               	cmpq	%rax, %rsi
               	setl	%r9b
               	movzbq	%r9b, %r9
               	cmpq	%rax, %rsi
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	%r8, %rdi
               	setb	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	orq	%r9, %rax
               	xorq	$0x1, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movl	$0x1, %esi
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x50(%rbp), %rax
               	movq	(%rax), %rdi
               	movq	0x8(%rax), %rsi
               	leaq	-0x40(%rbp), %rax
               	movq	(%rax), %r8
               	movq	0x8(%rax), %rax
               	cmpq	%rsi, %rax
               	setl	%r9b
               	movzbq	%r9b, %r9
               	cmpq	%rsi, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	%rdi, %r8
               	setb	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	orq	%r9, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%sil
               	movzbq	%sil, %rsi
               	movl	$0x1, %eax
               	testq	%rsi, %rsi
               	jne	<addr>
               	leaq	-0x40(%rbp), %rax
               	movq	(%rax), %rdi
               	movq	0x8(%rax), %rsi
               	leaq	-0x40(%rbp), %rax
               	movq	(%rax), %r8
               	movq	0x8(%rax), %rax
               	cmpq	%rsi, %rax
               	setl	%r9b
               	movzbq	%r9b, %r9
               	cmpq	%rsi, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	%rdi, %r8
               	setb	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	orq	%r9, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x40(%rbp), %rax
               	movq	(%rax), %rdi
               	movq	0x8(%rax), %rsi
               	leaq	-0x40(%rbp), %rax
               	movq	(%rax), %r8
               	movq	0x8(%rax), %rax
               	cmpq	%rsi, %rax
               	setl	%r9b
               	movzbq	%r9b, %r9
               	cmpq	%rsi, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	%rdi, %r8
               	setb	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	orq	%r9, %rax
               	xorq	$0x1, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x2c0, %rsp            # imm = 0x2C0
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	movq	(%rax), %rdi
               	movq	0x8(%rax), %rsi
               	leaq	-0x50(%rbp), %rax
               	movq	(%rax), %r8
               	movq	0x8(%rax), %rax
               	cmpq	%rsi, %rax
               	setb	%r9b
               	movzbq	%r9b, %r9
               	cmpq	%rsi, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	%rdi, %r8
               	setb	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	orq	%r9, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x40(%rbp), %rax
               	movq	(%rax), %rdi
               	movq	0x8(%rax), %rsi
               	leaq	-0x50(%rbp), %rax
               	movq	(%rax), %r8
               	movq	0x8(%rax), %rax
               	cmpq	%rsi, %rax
               	setb	%r9b
               	movzbq	%r9b, %r9
               	cmpq	%rsi, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	%rdi, %r8
               	setb	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	orq	%r9, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x2c0, %rsp            # imm = 0x2C0
               	popq	%rbp
               	retq
               	movq	(%rcx), %rdi
               	leaq	-0x228(%rbp), %rsi
               	movq	%rdi, (%rsi)
               	xorq	%rax, %rax
               	movq	%rax, 0x8(%rsi)
               	leaq	-0x238(%rbp), %rsi
               	movq	%rax, (%rsi)
               	movq	%rdi, 0x8(%rsi)
               	movq	%rax, %r8
               	orq	$0x5, %r8
               	orq	%rax, %rdi
               	leaq	-0x248(%rbp), %rsi
               	movq	%r8, (%rsi)
               	movq	%rdi, 0x8(%rsi)
               	leaq	-0x60(%rbp), %rdi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rsi
               	movq	(%rcx), %rdi
               	leaq	-0x258(%rbp), %rsi
               	movq	%rdi, (%rsi)
               	movq	%rax, 0x8(%rsi)
               	leaq	-0x268(%rbp), %rsi
               	movq	%rax, (%rsi)
               	movq	%rdi, 0x8(%rsi)
               	movabsq	$-0x8000000000000000, %rsi # imm = 0x8000000000000000
               	orq	%rax, %rsi
               	orq	%rax, %rdi
               	leaq	-0x278(%rbp), %rax
               	movq	%rsi, (%rax)
               	movq	%rdi, 0x8(%rax)
               	leaq	-0x70(%rbp), %rsi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	leaq	-0x60(%rbp), %rax
               	movq	(%rax), %rdi
               	movq	0x8(%rax), %rsi
               	leaq	-0x70(%rbp), %rax
               	movq	(%rax), %r8
               	movq	0x8(%rax), %rax
               	cmpq	%rax, %rsi
               	setl	%r9b
               	movzbq	%r9b, %r9
               	cmpq	%rax, %rsi
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	%r8, %rdi
               	setb	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	orq	%r9, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x60(%rbp), %rax
               	movq	(%rax), %rdi
               	movq	0x8(%rax), %rsi
               	leaq	-0x70(%rbp), %rax
               	movq	(%rax), %r8
               	movq	0x8(%rax), %rax
               	cmpq	%rax, %rsi
               	setl	%r9b
               	movzbq	%r9b, %r9
               	cmpq	%rax, %rsi
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	%r8, %rdi
               	setb	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	orq	%r9, %rax
               	xorq	$0x1, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x2c0, %rsp            # imm = 0x2C0
               	popq	%rbp
               	retq
               	leaq	-0x60(%rbp), %rax
               	movq	(%rax), %rdi
               	movq	0x8(%rax), %rsi
               	leaq	-0x70(%rbp), %rax
               	movq	(%rax), %r8
               	movq	0x8(%rax), %rax
               	cmpq	%rax, %rsi
               	setb	%r9b
               	movzbq	%r9b, %r9
               	cmpq	%rax, %rsi
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	%r8, %rdi
               	setb	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	orq	%r9, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x2c0, %rsp            # imm = 0x2C0
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rax
               	movq	(%rdx), %rdi
               	testq	%rax, %rax
               	setb	%r8b
               	movzbq	%r8b, %r8
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	%rdi, %rsi
               	setb	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	movq	%r8, %rsi
               	orq	%rax, %rsi
               	movl	$0x1, %eax
               	testq	%rsi, %rsi
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rax
               	movq	(%rcx), %rcx
               	testq	%rax, %rax
               	seta	%dil
               	movzbq	%dil, %rdi
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	%rsi, %rcx
               	setb	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	orq	%rdi, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	(%rdx), %rsi
               	leaq	-0x2a0(%rbp), %rax
               	movq	%rsi, (%rax)
               	xorq	%rcx, %rcx
               	movq	%rcx, 0x8(%rax)
               	movq	(%rdx), %rax
               	xorq	%rsi, %rax
               	xorq	%rcx, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x2c0, %rsp            # imm = 0x2C0
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x2c0, %rsp            # imm = 0x2C0
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
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
