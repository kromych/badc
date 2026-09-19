
indirect_call_target_scratch_exhausted.x64:	file format elf64-x86-64

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

<sum16p>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x100, %rsp            # imm = 0x100
               	movq	%rdi, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	%rdx, -0x20(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	movq	%r8, -0x30(%rbp)
               	movq	%r9, -0x28(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0x40(%rbp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, -0x38(%rbp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, -0x50(%rbp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, -0x48(%rbp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, -0x60(%rbp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, -0x58(%rbp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, -0x70(%rbp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, -0x68(%rbp)
               	movq	0x50(%rbp), %r10
               	movq	%r10, -0x80(%rbp)
               	movq	0x58(%rbp), %r10
               	movq	%r10, -0x78(%rbp)
               	movq	0x60(%rbp), %r10
               	movq	%r10, -0x90(%rbp)
               	movq	0x68(%rbp), %r10
               	movq	%r10, -0x88(%rbp)
               	movq	0x70(%rbp), %r10
               	movq	%r10, -0xa0(%rbp)
               	movq	0x78(%rbp), %r10
               	movq	%r10, -0x98(%rbp)
               	movq	0x80(%rbp), %r10
               	movq	%r10, -0xb0(%rbp)
               	movq	0x88(%rbp), %r10
               	movq	%r10, -0xa8(%rbp)
               	movq	0x90(%rbp), %r10
               	movq	%r10, -0xc0(%rbp)
               	movq	0x98(%rbp), %r10
               	movq	%r10, -0xb8(%rbp)
               	movq	0xa0(%rbp), %r10
               	movq	%r10, -0xd0(%rbp)
               	movq	0xa8(%rbp), %r10
               	movq	%r10, -0xc8(%rbp)
               	movq	0xb0(%rbp), %r10
               	movq	%r10, -0xe0(%rbp)
               	movq	0xb8(%rbp), %r10
               	movq	%r10, -0xd8(%rbp)
               	movq	0xc0(%rbp), %r10
               	movq	%r10, -0xf0(%rbp)
               	movq	0xc8(%rbp), %r10
               	movq	%r10, -0xe8(%rbp)
               	movq	0xd0(%rbp), %r10
               	movq	%r10, -0x100(%rbp)
               	movq	0xd8(%rbp), %r10
               	movq	%r10, -0xf8(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	addq	%rax, %rcx
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	0x8(%rax), %rax
               	addq	%rax, %rcx
               	leaq	-0x30(%rbp), %rax
               	movq	(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	0x8(%rax), %rax
               	addq	%rax, %rcx
               	leaq	-0x40(%rbp), %rax
               	movq	(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	0x8(%rax), %rax
               	addq	%rax, %rcx
               	leaq	-0x50(%rbp), %rax
               	movq	(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	0x8(%rax), %rax
               	addq	%rax, %rcx
               	leaq	-0x60(%rbp), %rax
               	movq	(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	0x8(%rax), %rax
               	addq	%rax, %rcx
               	leaq	-0x70(%rbp), %rax
               	movq	(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	0x8(%rax), %rax
               	addq	%rax, %rcx
               	leaq	-0x80(%rbp), %rax
               	movq	(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	0x8(%rax), %rax
               	addq	%rax, %rcx
               	leaq	-0x90(%rbp), %rax
               	movq	(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	0x8(%rax), %rax
               	addq	%rax, %rcx
               	leaq	-0xa0(%rbp), %rax
               	movq	(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	0x8(%rax), %rax
               	addq	%rax, %rcx
               	leaq	-0xb0(%rbp), %rax
               	movq	(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	0x8(%rax), %rax
               	addq	%rax, %rcx
               	leaq	-0xc0(%rbp), %rax
               	movq	(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	0x8(%rax), %rax
               	addq	%rax, %rcx
               	leaq	-0xd0(%rbp), %rax
               	movq	(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	0x8(%rax), %rax
               	addq	%rax, %rcx
               	leaq	-0xe0(%rbp), %rax
               	movq	(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	0x8(%rax), %rax
               	addq	%rax, %rcx
               	leaq	-0xf0(%rbp), %rax
               	movq	(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	0x8(%rax), %rax
               	addq	%rax, %rcx
               	leaq	-0x100(%rbp), %rax
               	movq	(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	0x8(%rax), %rax
               	addq	%rcx, %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x38, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rdx
               	leaq	(%rdx), %rax
               	movq	$0x0, (%rax)
               	movq	$0x0, 0x8(%rax)
               	leaq	<rip>, %rax
               	movq	$0x1, 0x10(%rax)
               	addq	$0x10, %rax
               	movq	$0x2, 0x8(%rax)
               	leaq	<rip>, %rax
               	movq	$0x2, 0x20(%rax)
               	addq	$0x20, %rax
               	movq	$0x4, 0x8(%rax)
               	leaq	<rip>, %rax
               	movq	$0x3, 0x30(%rax)
               	addq	$0x30, %rax
               	movq	$0x6, 0x8(%rax)
               	leaq	<rip>, %rax
               	movq	$0x4, 0x40(%rax)
               	addq	$0x40, %rax
               	movq	$0x8, 0x8(%rax)
               	leaq	<rip>, %rax
               	movq	$0x5, 0x50(%rax)
               	addq	$0x50, %rax
               	movq	$0xa, 0x8(%rax)
               	leaq	<rip>, %rax
               	movq	$0x6, 0x60(%rax)
               	addq	$0x60, %rax
               	movq	$0xc, 0x8(%rax)
               	leaq	<rip>, %rax
               	movq	$0x7, 0x70(%rax)
               	addq	$0x70, %rax
               	movq	$0xe, 0x8(%rax)
               	leaq	<rip>, %rax
               	movq	$0x8, 0x80(%rax)
               	addq	$0x80, %rax
               	movq	$0x10, 0x8(%rax)
               	leaq	<rip>, %rax
               	movq	$0x9, 0x90(%rax)
               	addq	$0x90, %rax
               	movq	$0x12, 0x8(%rax)
               	leaq	<rip>, %rax
               	movq	$0xa, 0xa0(%rax)
               	addq	$0xa0, %rax
               	movq	$0x14, 0x8(%rax)
               	leaq	<rip>, %rax
               	movq	$0xb, 0xb0(%rax)
               	addq	$0xb0, %rax
               	movq	$0x16, 0x8(%rax)
               	leaq	<rip>, %rax
               	movq	$0xc, 0xc0(%rax)
               	addq	$0xc0, %rax
               	movq	$0x18, 0x8(%rax)
               	leaq	<rip>, %rax
               	movq	$0xd, 0xd0(%rax)
               	addq	$0xd0, %rax
               	movq	$0x1a, 0x8(%rax)
               	leaq	<rip>, %rax
               	movq	$0xe, 0xe0(%rax)
               	addq	$0xe0, %rax
               	movq	$0x1c, 0x8(%rax)
               	leaq	<rip>, %rax
               	movq	$0xf, 0xf0(%rax)
               	addq	$0xf0, %rax
               	movq	$0x1e, 0x8(%rax)
               	leaq	<rip>, %rdi
               	leaq	0x10(%rdi), %rdx
               	leaq	0x20(%rdi), %r8
               	leaq	0x30(%rdi), %rax
               	leaq	0x40(%rdi), %rcx
               	leaq	0x50(%rdi), %rsi
               	leaq	0x60(%rdi), %r9
               	leaq	0x70(%rdi), %rbx
               	leaq	0x80(%rdi), %r12
               	leaq	0x90(%rdi), %r13
               	leaq	0xa0(%rdi), %r14
               	leaq	0xb0(%rdi), %r15
               	leaq	0xc0(%rdi), %r10
               	movq	%r10, 0x58(%rsp)
               	leaq	0xd0(%rdi), %r10
               	movq	%r10, 0x50(%rsp)
               	leaq	0xe0(%rdi), %r10
               	movq	%r10, 0x48(%rsp)
               	leaq	0xf0(%rdi), %r10
               	movq	%r10, 0x40(%rsp)
               	subq	$0xd0, %rsp
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rsi, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%rbx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	%r12, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x50(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x58(%rsp)
               	movq	%r13, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x60(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x68(%rsp)
               	movq	%r14, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x70(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x78(%rsp)
               	movq	%r15, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x80(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x88(%rsp)
               	movq	0x128(%rsp), %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x90(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x98(%rsp)
               	movq	0x120(%rsp), %r10
               	movq	(%r10), %r11
               	movq	%r11, 0xa0(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0xa8(%rsp)
               	movq	0x118(%rsp), %r10
               	movq	(%r10), %r11
               	movq	%r11, 0xb0(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0xb8(%rsp)
               	movq	0x110(%rsp), %r10
               	movq	(%r10), %r11
               	movq	%r11, 0xc0(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0xc8(%rsp)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	movq	0x8(%r8), %r9
               	movq	(%r8), %r8
               	callq	<addr>
               	addq	$0xd0, %rsp
               	cmpq	$0x168, %rax            # imm = 0x168
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
