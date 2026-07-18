
int128_struct_fallback.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<lshift>:
               	popq	%r10
               	subq	$0x20, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	%rdx, %rsi
               	movslq	%esi, %rsi
               	cmpq	$0x40, %rsi
               	jl	<addr>
               	xorq	%rcx, %rcx
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rdx
               	leaq	-0x40(%rsi), %rax
               	movslq	%eax, %rax
               	pushq	%rcx
               	movq	%rax, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	leaq	-0x50(%rbp), %rax
               	leaq	<rip>, %rsi
               	pushq	%rcx
               	movq	(%rsi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0x50(%rbp), %rax
               	movq	%rcx, (%rax)
               	leaq	-0x50(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	leaq	-0x50(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	addq	$0x70, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rax
               	movq	%rax, %rcx
               	movq	%rcx, %r11
               	movq	%rsi, %rcx
               	shlq	%cl, %r11
               	movq	%r11, %rcx
               	leaq	-0x10(%rbp), %rax
               	movq	0x8(%rax), %rax
               	movq	%rax, %rdx
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	testq	%rsi, %rsi
               	je	<addr>
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rdi
               	movl	$0x40, %eax
               	subq	%rsi, %rax
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	movq	%rdi, %rax
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rax
               	popq	%rcx
               	orq	%rax, %rdx
               	leaq	-0x68(%rbp), %rax
               	leaq	<rip>, %rsi
               	pushq	%rcx
               	movq	(%rsi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0x68(%rbp), %rax
               	movq	%rcx, (%rax)
               	leaq	-0x68(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	leaq	-0x68(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	addq	$0x70, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	xorq	%rax, %rax
               	jmp	<addr>

<rshift>:
               	popq	%r10
               	subq	$0x20, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	%rdx, %rsi
               	movslq	%esi, %rsi
               	cmpq	$0x40, %rsi
               	jl	<addr>
               	leaq	-0x10(%rbp), %rax
               	movq	0x8(%rax), %rcx
               	leaq	-0x40(%rsi), %rax
               	movslq	%eax, %rax
               	movq	%rcx, %r11
               	movq	%rax, %rcx
               	sarq	%cl, %r11
               	movq	%r11, %rcx
               	leaq	-0x10(%rbp), %rax
               	movq	0x8(%rax), %rax
               	movq	%rax, %rdx
               	sarq	$0x3f, %rdx
               	leaq	-0x50(%rbp), %rax
               	leaq	<rip>, %rsi
               	pushq	%rcx
               	movq	(%rsi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0x50(%rbp), %rax
               	movq	%rcx, (%rax)
               	leaq	-0x50(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	leaq	-0x50(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	addq	$0x60, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rax
               	movq	%rax, %rcx
               	movq	%rcx, %r11
               	movq	%rsi, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	leaq	-0x10(%rbp), %rax
               	movq	0x8(%rax), %rdx
               	movl	$0x40, %eax
               	subq	%rsi, %rax
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	movq	%rdx, %rax
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rax
               	popq	%rcx
               	orq	%rax, %rcx
               	leaq	-0x10(%rbp), %rax
               	movq	0x8(%rax), %rax
               	movq	%rax, %rdx
               	pushq	%rcx
               	movq	%rsi, %rcx
               	sarq	%cl, %rdx
               	popq	%rcx
               	leaq	-0x60(%rbp), %rax
               	leaq	<rip>, %rsi
               	pushq	%rcx
               	movq	(%rsi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0x60(%rbp), %rax
               	movq	%rcx, (%rax)
               	leaq	-0x60(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	leaq	-0x60(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	addq	$0x60, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq

<eq>:
               	popq	%r10
               	subq	$0x20, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	%rdx, -0x20(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rax
               	leaq	-0x20(%rbp), %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rcx, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	-0x10(%rbp), %rax
               	movq	0x8(%rax), %rcx
               	leaq	-0x20(%rbp), %rax
               	movq	0x8(%rax), %rax
               	cmpq	%rax, %rcx
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	jmp	<addr>

<lt>:
               	popq	%r10
               	subq	$0x20, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	%rdx, -0x20(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movq	0x8(%rax), %rcx
               	leaq	-0x20(%rbp), %rax
               	movq	0x8(%rax), %rax
               	cmpq	%rax, %rcx
               	setl	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movq	0x8(%rax), %rcx
               	leaq	-0x20(%rbp), %rax
               	movq	0x8(%rax), %rax
               	cmpq	%rax, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rax
               	leaq	-0x20(%rbp), %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rcx, %rax
               	setb	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	jmp	<addr>
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x280, %rsp            # imm = 0x280
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movabsq	$-0x1, %rax
               	leaq	-0x108(%rbp), %rcx
               	leaq	<rip>, %rbx
               	pushq	%rax
               	movq	(%rbx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rbx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x108(%rbp), %rcx
               	movq	%rax, (%rcx)
               	xorq	%rcx, %rcx
               	leaq	-0x108(%rbp), %rax
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x108(%rbp), %rax
               	movl	$0x1, %ecx
               	leaq	-0x118(%rbp), %rdx
               	leaq	<rip>, %rsi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	leaq	-0x118(%rbp), %rdx
               	movq	%rcx, (%rdx)
               	xorq	%rdx, %rdx
               	leaq	-0x118(%rbp), %rcx
               	movq	%rdx, 0x8(%rcx)
               	leaq	-0x118(%rbp), %rcx
               	movq	(%rax), %rdx
               	movq	(%rcx), %rsi
               	addq	%rdx, %rsi
               	movq	0x8(%rax), %rdi
               	movq	0x8(%rcx), %rcx
               	addq	%rdi, %rcx
               	cmpq	%rdx, %rsi
               	setb	%al
               	movzbq	%al, %rax
               	addq	%rax, %rcx
               	leaq	-0x128(%rbp), %rax
               	leaq	<rip>, %r13
               	pushq	%rcx
               	movq	(%r13), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%r13), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0x128(%rbp), %rax
               	movq	%rsi, (%rax)
               	leaq	-0x128(%rbp), %rax
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x128(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movq	0x8(%rax), %rax
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x280, %rsp            # imm = 0x280
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movl	$0x1, %ecx
               	leaq	-0x140(%rbp), %rdx
               	pushq	%rax
               	movq	(%r13), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%r13), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	leaq	-0x140(%rbp), %rdx
               	movq	%rax, (%rdx)
               	leaq	-0x140(%rbp), %rax
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x140(%rbp), %rax
               	leaq	-0x150(%rbp), %rdx
               	pushq	%rax
               	movq	(%rbx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rbx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	leaq	-0x150(%rbp), %rdx
               	movq	%rcx, (%rdx)
               	xorq	%rdx, %rdx
               	leaq	-0x150(%rbp), %rcx
               	movq	%rdx, 0x8(%rcx)
               	leaq	-0x150(%rbp), %rcx
               	movq	(%rax), %rdx
               	movq	(%rcx), %rsi
               	movq	%rdx, %rdi
               	subq	%rsi, %rdi
               	movq	0x8(%rax), %r8
               	movq	0x8(%rcx), %r9
               	subq	%r9, %r8
               	cmpq	%rsi, %rdx
               	setb	%al
               	movzbq	%al, %rax
               	movq	%r8, %rcx
               	subq	%rax, %rcx
               	leaq	-0x160(%rbp), %rax
               	pushq	%rcx
               	movq	(%r13), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%r13), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0x160(%rbp), %rax
               	movq	%rdi, (%rax)
               	leaq	-0x160(%rbp), %rax
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x160(%rbp), %rax
               	leaq	-0x30(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x30(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	$-0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x30(%rbp), %rax
               	movq	0x8(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x280, %rsp            # imm = 0x280
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	leaq	-0x178(%rbp), %rcx
               	pushq	%rax
               	movq	(%rbx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rbx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x178(%rbp), %rcx
               	movq	%rax, (%rcx)
               	xorq	%rcx, %rcx
               	leaq	-0x178(%rbp), %rax
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x178(%rbp), %rax
               	movq	(%rax), %rcx
               	xorq	$-0x1, %rcx
               	incq	%rcx
               	movq	0x8(%rax), %rax
               	xorq	$-0x1, %rax
               	testq	%rcx, %rcx
               	sete	%dl
               	movzbq	%dl, %rdx
               	addq	%rax, %rdx
               	leaq	-0x188(%rbp), %rax
               	pushq	%rcx
               	movq	(%r13), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%r13), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0x188(%rbp), %rax
               	movq	%rcx, (%rax)
               	leaq	-0x188(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	leaq	-0x188(%rbp), %rax
               	leaq	-0x50(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x50(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	$-0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x50(%rbp), %rax
               	movq	0x8(%rax), %rax
               	cmpq	$-0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x280, %rsp            # imm = 0x280
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	leaq	-0x1a0(%rbp), %rcx
               	pushq	%rax
               	movq	(%rbx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rbx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x1a0(%rbp), %rcx
               	movq	%rax, (%rcx)
               	xorq	%rcx, %rcx
               	leaq	-0x1a0(%rbp), %rax
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x1a0(%rbp), %rdi
               	movl	$0x40, %esi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x1b0(%rbp)
               	movq	%rdx, -0x1a8(%rbp)
               	leaq	-0x1b0(%rbp), %rax
               	leaq	-0x70(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x70(%rbp), %rax
               	movq	(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x70(%rbp), %rax
               	movq	0x8(%rax), %rax
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x280, %rsp            # imm = 0x280
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	leaq	-0x1c8(%rbp), %rcx
               	pushq	%rax
               	movq	(%rbx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rbx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x1c8(%rbp), %rcx
               	movq	%rax, (%rcx)
               	xorq	%rcx, %rcx
               	leaq	-0x1c8(%rbp), %rax
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x1c8(%rbp), %rdi
               	movl	$0x64, %esi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x1d8(%rbp)
               	movq	%rdx, -0x1d0(%rbp)
               	leaq	-0x1d8(%rbp), %rax
               	leaq	-0x90(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x90(%rbp), %rax
               	movq	(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x90(%rbp), %rax
               	movq	0x8(%rax), %rax
               	movabsq	$0x1000000000, %r11     # imm = 0x1000000000
               	cmpq	%r11, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x280, %rsp            # imm = 0x280
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	leaq	-0x1f0(%rbp), %rdx
               	pushq	%rax
               	movq	(%r13), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%r13), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	leaq	-0x1f0(%rbp), %rdx
               	movq	%rax, (%rdx)
               	leaq	-0x1f0(%rbp), %rax
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x1f0(%rbp), %rdi
               	movl	$0x4, %esi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x200(%rbp)
               	movq	%rdx, -0x1f8(%rbp)
               	leaq	-0x200(%rbp), %rax
               	leaq	-0xb0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0xb0(%rbp), %rax
               	movq	0x8(%rax), %rax
               	movabsq	$-0x800000000000000, %r11 # imm = 0xF800000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x280, %rsp            # imm = 0x280
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rdi
               	xorq	%rax, %rax
               	movl	$0x1, %r12d
               	leaq	-0x220(%rbp), %rcx
               	pushq	%rax
               	movq	(%r13), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%r13), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x220(%rbp), %rcx
               	movq	%rax, (%rcx)
               	leaq	-0x220(%rbp), %rax
               	movq	%r12, 0x8(%rax)
               	leaq	-0x220(%rbp), %rsi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5, %eax
               	leaq	-0x230(%rbp), %rcx
               	pushq	%rax
               	movq	(%rbx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rbx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x230(%rbp), %rcx
               	movq	%rax, (%rcx)
               	xorq	%rcx, %rcx
               	leaq	-0x230(%rbp), %rax
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x230(%rbp), %rdi
               	movl	$0x9, %eax
               	leaq	-0x240(%rbp), %rcx
               	pushq	%rax
               	movq	(%rbx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rbx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x240(%rbp), %rcx
               	movq	%rax, (%rcx)
               	xorq	%rcx, %rcx
               	leaq	-0x240(%rbp), %rax
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x240(%rbp), %rsi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%r12b
               	movzbq	%r12b, %r12
               	testq	%r12, %r12
               	jne	<addr>
               	movl	$0x9, %eax
               	leaq	-0x250(%rbp), %rcx
               	pushq	%rax
               	movq	(%rbx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rbx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x250(%rbp), %rcx
               	movq	%rax, (%rcx)
               	xorq	%rcx, %rcx
               	leaq	-0x250(%rbp), %rax
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x250(%rbp), %rdi
               	movl	$0x5, %eax
               	leaq	-0x260(%rbp), %rcx
               	pushq	%rax
               	movq	(%rbx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rbx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x260(%rbp), %rcx
               	movq	%rax, (%rcx)
               	xorq	%rcx, %rcx
               	leaq	-0x260(%rbp), %rax
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x260(%rbp), %rsi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, %r12
               	testq	%r12, %r12
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x280, %rsp            # imm = 0x280
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x280, %rsp            # imm = 0x280
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
