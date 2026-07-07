
struct_arg_in_registers.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<sum_pair>:
               	popq	%r10
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rcx
               	leaq	-0x8(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<sum_wide>:
               	popq	%r10
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rcx
               	leaq	-0x10(%rbp), %rax
               	movq	0x8(%rax), %rax
               	addq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<sum_mixed>:
               	popq	%r10
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %rcx
               	leaq	-0x10(%rbp), %rax
               	movswq	0x4(%rax), %rax
               	addq	%rcx, %rax
               	leaq	-0x10(%rbp), %rcx
               	movswq	0x6(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	-0x10(%rbp), %rcx
               	movslq	0x8(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<sum_nested>:
               	popq	%r10
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %rcx
               	leaq	-0x10(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	addq	%rcx, %rax
               	leaq	-0x10(%rbp), %rcx
               	movslq	0x8(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<around>:
               	popq	%r10
               	subq	$0x30, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rsi, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rax
               	imulq	$0xa, %rax, %rax
               	addq	%rdi, %rax
               	leaq	-0x8(%rbp), %rcx
               	movslq	0x4(%rcx), %rcx
               	imulq	$0x64, %rcx, %rcx
               	addq	%rcx, %rax
               	imulq	$0x3e8, %rdx, %rcx      # imm = 0x3E8
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x30, %rsp
               	pushq	%r11
               	retq

<two>:
               	popq	%r10
               	subq	$0x20, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x8(%rbp)
               	movq	%rsi, -0x10(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rcx
               	leaq	-0x8(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	shlq	$0x1, %rax
               	addq	%rcx, %rax
               	leaq	-0x10(%rbp), %rcx
               	movslq	(%rcx), %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	%rcx, %rax
               	leaq	-0x10(%rbp), %rcx
               	movslq	0x4(%rcx), %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq

<mutate>:
               	popq	%r10
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x64, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0xc8, %ecx
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rcx
               	leaq	-0x8(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	leaq	-0x8(%rbp), %rax
               	movl	$0x3, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x5, %ecx
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rcx
               	movslq	0x4(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movl	$0x3e8, %ecx            # imm = 0x3E8
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x151, %ecx            # imm = 0x151
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x18(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	addq	%rcx, %rax
               	cmpq	$0x539, %rax            # imm = 0x539
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %rax
               	movl	$0x1, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x28(%rbp), %rax
               	movl	$0x2, %ecx
               	movw	%cx, 0x4(%rax)
               	leaq	-0x28(%rbp), %rax
               	movl	$0x3, %ecx
               	movw	%cx, 0x6(%rax)
               	leaq	-0x28(%rbp), %rax
               	movl	$0x4, %ecx
               	movl	%ecx, 0x8(%rax)
               	leaq	-0x28(%rbp), %rax
               	movslq	(%rax), %rcx
               	movswq	0x4(%rax), %rdx
               	addq	%rdx, %rcx
               	movswq	0x6(%rax), %rdx
               	addq	%rdx, %rcx
               	movslq	0x8(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x38(%rbp), %rax
               	movl	$0x7, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x38(%rbp), %rax
               	movl	$0xb, %ecx
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x38(%rbp), %rax
               	movl	$0xd, %ecx
               	movl	%ecx, 0x8(%rax)
               	leaq	-0x38(%rbp), %rax
               	movslq	(%rax), %rcx
               	movslq	0x4(%rax), %rdx
               	addq	%rdx, %rcx
               	movslq	0x8(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpq	$0x1f, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rcx
               	imulq	$0xa, %rcx, %rcx
               	addq	$0x9, %rcx
               	movslq	0x4(%rax), %rax
               	imulq	$0x64, %rax, %rax
               	addq	%rcx, %rax
               	addq	$0x7d0, %rax            # imm = 0x7D0
               	movslq	%eax, %rax
               	cmpq	$0x9eb, %rax            # imm = 0x9EB
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %rcx
               	movl	$0x1, %eax
               	movl	%eax, (%rcx)
               	leaq	-0x40(%rbp), %rcx
               	movl	%eax, 0x4(%rcx)
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x40(%rbp), %rcx
               	movslq	(%rax), %rdx
               	movslq	0x4(%rax), %rax
               	shlq	$0x1, %rax
               	addq	%rdx, %rax
               	movslq	(%rcx), %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	addq	%rdx, %rax
               	movslq	0x4(%rcx), %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpq	$0x14, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rdi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	cmpq	$0x12c, %rax            # imm = 0x12C
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x3, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x8(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x5, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
