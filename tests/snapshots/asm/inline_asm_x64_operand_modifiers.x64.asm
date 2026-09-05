
inline_asm_x64_operand_modifiers.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movl	$0x8002, %eax           # imm = 0x8002
               	movw	%ax, -0x10(%rbp)
               	movl	$0x81, %eax
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, -0x30(%rbp)
               	movq	%rax, -0x28(%rbp)
               	movq	-0x28(%rbp), %r10
               	movzbq	(%r10), %rax
               	shrb	%al
               	movq	-0x28(%rbp), %r10
               	movb	%al, (%r10)
               	movq	-0x30(%rbp), %rax
               	movzbq	-0x8(%rbp), %rax
               	xorq	$0x40, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0x8001, %eax           # imm = 0x8001
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, -0x30(%rbp)
               	movq	%rax, -0x28(%rbp)
               	movq	-0x28(%rbp), %r10
               	movzwq	(%r10), %rax
               	shrw	%ax
               	movq	-0x28(%rbp), %r10
               	movw	%ax, (%r10)
               	movq	-0x30(%rbp), %rax
               	movzwq	-0x8(%rbp), %rax
               	xorq	$0x4000, %rax           # imm = 0x4000
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0x80000001, %eax       # imm = 0x80000001
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, -0x30(%rbp)
               	movq	%rax, -0x28(%rbp)
               	movq	-0x28(%rbp), %r10
               	movl	(%r10), %eax
               	shrl	%eax
               	movq	-0x28(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x30(%rbp), %rax
               	movl	-0x8(%rbp), %eax
               	cmpl	$0x40000000, %eax       # imm = 0x40000000
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movabsq	$-0x7fffffffffffffff, %rax # imm = 0x8000000000000001
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, -0x30(%rbp)
               	movq	%rax, -0x28(%rbp)
               	movq	-0x28(%rbp), %r10
               	movq	(%r10), %rax
               	shrq	%rax
               	movq	-0x28(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x30(%rbp), %rax
               	movq	-0x8(%rbp), %rax
               	movabsq	$0x4000000000000000, %r11 # imm = 0x4000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	%rax, -0x30(%rbp)
               	movq	%rax, -0x28(%rbp)
               	movq	-0x28(%rbp), %rax
               	shrw	(%rax)
               	movq	-0x30(%rbp), %rax
               	movzwq	-0x10(%rbp), %rax
               	xorq	$0x4001, %rax           # imm = 0x4001
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	movl	$0x12345678, %ecx       # imm = 0x12345678
               	movq	%rax, -0x30(%rbp)
               	movq	%rdx, -0x28(%rbp)
               	movq	%rax, -0x20(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	movq	-0x18(%rbp), %rdx
               	movb	%dh, %al
               	movq	-0x20(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x30(%rbp), %rax
               	movq	-0x28(%rbp), %rdx
               	movl	-0x8(%rbp), %eax
               	andq	$0xff, %rax
               	xorq	$0x56, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	movl	$0x80000040, %ecx       # imm = 0x80000040
               	movq	%rax, -0x30(%rbp)
               	movq	%r8, -0x28(%rbp)
               	movq	%rax, -0x20(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	movl	$0x80000040, %r8d       # imm = 0x80000040
               	movl	%r8d, %eax
               	movq	-0x20(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x30(%rbp), %rax
               	movq	-0x28(%rbp), %r8
               	movl	-0x8(%rbp), %eax
               	movl	$0x80000040, %r11d      # imm = 0x80000040
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movl	$0x1e, %eax
               	movq	%rax, -0x8(%rbp)
               	movl	$0xc, %eax
               	leaq	-0x8(%rbp), %rcx
               	movq	%rax, -0x30(%rbp)
               	movq	%rcx, -0x28(%rbp)
               	movq	%rax, -0x20(%rbp)
               	movq	-0x28(%rbp), %r10
               	movq	(%r10), %rax
               	addq	$0xc, %rax
               	movq	-0x28(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x30(%rbp), %rax
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movl	$0x23, %eax
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x7, %ecx
               	movq	%rax, -0x30(%rbp)
               	movq	%rax, -0x28(%rbp)
               	movq	%rcx, -0x20(%rbp)
               	movq	-0x28(%rbp), %r10
               	movq	(%r10), %rax
               	addq	$0x7, %rax
               	movq	-0x28(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x30(%rbp), %rax
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movl	$0x27, %eax
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x3, %ecx
               	movq	%rax, -0x30(%rbp)
               	movq	%rax, -0x28(%rbp)
               	movq	%rcx, -0x20(%rbp)
               	movq	-0x28(%rbp), %r10
               	movq	(%r10), %rax
               	addq	$0x3, %rax
               	movq	-0x28(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x30(%rbp), %rax
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	movl	$0x2, %eax
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x28, %ecx
               	movq	%rax, -0x30(%rbp)
               	movq	%rbx, -0x28(%rbp)
               	movq	%rax, -0x20(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	movq	-0x20(%rbp), %r10
               	movq	(%r10), %rax
               	movq	-0x18(%rbp), %rbx
               	addq	%rbx, %rax
               	movq	-0x20(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x30(%rbp), %rax
               	movq	-0x28(%rbp), %rbx
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movl	$0x5, %eax
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x3, %ecx
               	movq	%rax, -0x30(%rbp)
               	movq	%rcx, -0x28(%rbp)
               	movq	%rax, -0x20(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	movq	-0x20(%rbp), %r10
               	movq	(%r10), %rax
               	shlq	$0x3, %rax
               	movq	-0x20(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x30(%rbp), %rax
               	movq	-0x28(%rbp), %rcx
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x28, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	movl	$0x15, %eax
               	movq	%rax, -0x8(%rbp)
               	movl	$0x1, %eax
               	leaq	-0x8(%rbp), %rcx
               	movq	%rax, -0x30(%rbp)
               	movq	%rcx, -0x28(%rbp)
               	movq	%rcx, -0x20(%rbp)
               	movq	%rax, -0x18(%rbp)
               	movq	-0x20(%rbp), %r10
               	movq	(%r10), %rax
               	shlq	%rax
               	movq	-0x20(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x30(%rbp), %rax
               	movq	-0x28(%rbp), %rcx
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	movl	$0x2a, %eax
               	leave
               	retq
