
struct_arg_by_stack.x64:	file format elf64-x86-64

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

<take>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rsi, -0x30(%rbp)
               	movq	%rdx, -0x28(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0x20(%rbp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, -0x18(%rbp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, -0x10(%rbp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, -0x8(%rbp)
               	movl	$0x7, %eax
               	leaq	<rip>, %rcx
               	movq	%rax, (%rcx)
               	leaq	<rip>, %rcx
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	leaq	<rip>, %rcx
               	movq	0x8(%rax), %rdx
               	movq	%rdx, (%rcx)
               	leaq	<rip>, %rcx
               	movq	0x10(%rax), %rdx
               	movq	%rdx, (%rcx)
               	leaq	<rip>, %rcx
               	movq	0x18(%rax), %rax
               	movq	%rax, (%rcx)
               	leaq	<rip>, %rcx
               	leaq	-0x30(%rbp), %rax
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	leaq	<rip>, %rcx
               	movq	0x8(%rax), %rax
               	movq	%rax, (%rcx)
               	xorq	%rax, %rax
               	leave
               	retq

<mutate>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0x20(%rbp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, -0x18(%rbp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, -0x10(%rbp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, -0x8(%rbp)
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rcx
               	addq	$0x3e8, %rcx            # imm = 0x3E8
               	movq	%rcx, (%rax)
               	movq	0x18(%rax), %rdx
               	decq	%rdx
               	movq	%rdx, 0x18(%rax)
               	movq	0x8(%rax), %rsi
               	addq	%rsi, %rcx
               	movq	0x10(%rax), %rax
               	addq	%rax, %rcx
               	leaq	(%rcx,%rdx), %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	-0x20(%rbp), %rsi
               	movl	$0xb, %eax
               	movq	%rax, (%rsi)
               	movl	$0x16, %eax
               	movq	%rax, 0x8(%rsi)
               	movl	$0x21, %eax
               	movq	%rax, 0x10(%rsi)
               	movl	$0x2c, %eax
               	movq	%rax, 0x18(%rsi)
               	leaq	-0x30(%rbp), %rdx
               	movl	$0x5, %eax
               	movq	%rax, (%rdx)
               	movl	$0x6, %eax
               	movq	%rax, 0x8(%rdx)
               	movl	$0x7, %edi
               	subq	$0x20, %rsp
               	movq	%rsi, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
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
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0xb, %rax
               	movl	$0x1, %eax
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	$0x16, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x21, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2c, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x5, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x6, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	-0x20(%rbp), %rdi
               	subq	$0x20, %rsp
               	movq	%rdi, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	cmpq	$0x455, %rax            # imm = 0x455
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	-0x20(%rbp), %rcx
               	movq	(%rcx), %rax
               	cmpq	$0xb, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	0x18(%rcx), %rax
               	cmpq	$0x2c, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	leave
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
