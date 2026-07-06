
indirect_call_target_scratch_exhausted.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<sum17>:
               	popq	%r10
               	subq	$0x110, %rsp            # imm = 0x110
               	movq	0x110(%rsp), %rax
               	movq	%rax, 0x60(%rsp)
               	movq	0x118(%rsp), %rax
               	movq	%rax, 0x70(%rsp)
               	movq	0x120(%rsp), %rax
               	movq	%rax, 0x80(%rsp)
               	movq	0x128(%rsp), %rax
               	movq	%rax, 0x90(%rsp)
               	movq	0x130(%rsp), %rax
               	movq	%rax, 0xa0(%rsp)
               	movq	0x138(%rsp), %rax
               	movq	%rax, 0xb0(%rsp)
               	movq	0x140(%rsp), %rax
               	movq	%rax, 0xc0(%rsp)
               	movq	0x148(%rsp), %rax
               	movq	%rax, 0xd0(%rsp)
               	movq	0x150(%rsp), %rax
               	movq	%rax, 0xe0(%rsp)
               	movq	0x158(%rsp), %rax
               	movq	%rax, 0xf0(%rsp)
               	movq	0x160(%rsp), %rax
               	movq	%rax, 0x100(%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	(%rdi,%rsi), %rax
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	addq	%r8, %rax
               	addq	%r9, %rax
               	movq	0x70(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	0x80(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	0x90(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	0xa0(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	0xb0(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	0xc0(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	0xd0(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	0xe0(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	0xf0(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	0x100(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	0x110(%rbp), %rcx
               	addq	%rcx, %rax
               	popq	%rbp
               	popq	%r11
               	addq	$0x110, %rsp            # imm = 0x110
               	pushq	%r11
               	retq

<sum16p>:
               	popq	%r10
               	subq	$0x100, %rsp            # imm = 0x100
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x100, %rsp            # imm = 0x100
               	movq	%rdi, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	%rdx, -0x20(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	movq	%r8, -0x30(%rbp)
               	movq	%r9, -0x28(%rbp)
               	movq	0x110(%rbp), %r10
               	movq	%r10, -0x40(%rbp)
               	movq	0x118(%rbp), %r10
               	movq	%r10, -0x38(%rbp)
               	movq	0x120(%rbp), %r10
               	movq	%r10, -0x50(%rbp)
               	movq	0x128(%rbp), %r10
               	movq	%r10, -0x48(%rbp)
               	movq	0x130(%rbp), %r10
               	movq	%r10, -0x60(%rbp)
               	movq	0x138(%rbp), %r10
               	movq	%r10, -0x58(%rbp)
               	movq	0x140(%rbp), %r10
               	movq	%r10, -0x70(%rbp)
               	movq	0x148(%rbp), %r10
               	movq	%r10, -0x68(%rbp)
               	movq	0x150(%rbp), %r10
               	movq	%r10, -0x80(%rbp)
               	movq	0x158(%rbp), %r10
               	movq	%r10, -0x78(%rbp)
               	movq	0x160(%rbp), %r10
               	movq	%r10, -0x90(%rbp)
               	movq	0x168(%rbp), %r10
               	movq	%r10, -0x88(%rbp)
               	movq	0x170(%rbp), %r10
               	movq	%r10, -0xa0(%rbp)
               	movq	0x178(%rbp), %r10
               	movq	%r10, -0x98(%rbp)
               	movq	0x180(%rbp), %r10
               	movq	%r10, -0xb0(%rbp)
               	movq	0x188(%rbp), %r10
               	movq	%r10, -0xa8(%rbp)
               	movq	0x190(%rbp), %r10
               	movq	%r10, -0xc0(%rbp)
               	movq	0x198(%rbp), %r10
               	movq	%r10, -0xb8(%rbp)
               	movq	0x1a0(%rbp), %r10
               	movq	%r10, -0xd0(%rbp)
               	movq	0x1a8(%rbp), %r10
               	movq	%r10, -0xc8(%rbp)
               	movq	0x1b0(%rbp), %r10
               	movq	%r10, -0xe0(%rbp)
               	movq	0x1b8(%rbp), %r10
               	movq	%r10, -0xd8(%rbp)
               	movq	0x1c0(%rbp), %r10
               	movq	%r10, -0xf0(%rbp)
               	movq	0x1c8(%rbp), %r10
               	movq	%r10, -0xe8(%rbp)
               	movq	0x1d0(%rbp), %r10
               	movq	%r10, -0x100(%rbp)
               	movq	0x1d8(%rbp), %r10
               	movq	%r10, -0xf8(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rax
               	leaq	-0x10(%rbp), %rcx
               	movq	0x8(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	-0x20(%rbp), %rcx
               	movq	(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	-0x20(%rbp), %rcx
               	movq	0x8(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	-0x30(%rbp), %rcx
               	movq	(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	-0x30(%rbp), %rcx
               	movq	0x8(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	-0x40(%rbp), %rcx
               	movq	(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	-0x40(%rbp), %rcx
               	movq	0x8(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	-0x50(%rbp), %rcx
               	movq	(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	-0x50(%rbp), %rcx
               	movq	0x8(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	-0x60(%rbp), %rcx
               	movq	(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	-0x60(%rbp), %rcx
               	movq	0x8(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	-0x70(%rbp), %rcx
               	movq	(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	-0x70(%rbp), %rcx
               	movq	0x8(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	-0x80(%rbp), %rcx
               	movq	(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	-0x80(%rbp), %rcx
               	movq	0x8(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	-0x90(%rbp), %rcx
               	movq	(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	-0x90(%rbp), %rcx
               	movq	0x8(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	-0xa0(%rbp), %rcx
               	movq	(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	-0xa0(%rbp), %rcx
               	movq	0x8(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	-0xb0(%rbp), %rcx
               	movq	(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	-0xb0(%rbp), %rcx
               	movq	0x8(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	-0xc0(%rbp), %rcx
               	movq	(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	-0xc0(%rbp), %rcx
               	movq	0x8(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	-0xd0(%rbp), %rcx
               	movq	(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	-0xd0(%rbp), %rcx
               	movq	0x8(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	-0xe0(%rbp), %rcx
               	movq	(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	-0xe0(%rbp), %rcx
               	movq	0x8(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	-0xf0(%rbp), %rcx
               	movq	(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	-0xf0(%rbp), %rcx
               	movq	0x8(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	-0x100(%rbp), %rcx
               	movq	(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	-0x100(%rbp), %rcx
               	movq	0x8(%rcx), %rcx
               	addq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	popq	%r11
               	addq	$0x100, %rsp            # imm = 0x100
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	leaq	-<rip>, %rax      # <addr>
               	leaq	-<rip>, %rbx      # <addr>
               	xorq	%rdx, %rdx
               	cmpq	$0x10, %rdx
               	jge	<addr>
               	jmp	<addr>
               	incq	%rdx
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	%rdx, %rsi
               	shlq	$0x4, %rsi
               	addq	%rcx, %rsi
               	movq	%rdx, (%rsi)
               	movq	%rdx, %rsi
               	shlq	$0x4, %rsi
               	addq	%rsi, %rcx
               	movq	%rdx, %rsi
               	shlq	$0x1, %rsi
               	movq	%rsi, 0x8(%rcx)
               	jmp	<addr>
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	movl	$0x3, %edx
               	movl	$0x4, %ecx
               	movl	$0x5, %r8d
               	movl	$0x6, %r9d
               	movl	$0x7, %r12d
               	movl	$0x8, %r13d
               	movl	$0x9, %r14d
               	movl	$0xa, %r15d
               	movl	$0xb, %r10d
               	movq	%r10, 0x68(%rsp)
               	movl	$0xc, %r10d
               	movq	%r10, 0x60(%rsp)
               	movl	$0xd, %r10d
               	movq	%r10, 0x58(%rsp)
               	movl	$0xe, %r10d
               	movq	%r10, 0x50(%rsp)
               	movl	$0xf, %r10d
               	movq	%r10, 0x48(%rsp)
               	movl	$0x10, %r10d
               	movq	%r10, 0x40(%rsp)
               	movl	$0x11, %r10d
               	movq	%r10, 0x38(%rsp)
               	subq	$0x60, %rsp
               	movq	%r12, (%rsp)
               	movq	%r13, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	0xc8(%rsp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0xc0(%rsp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0xb8(%rsp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0xb0(%rsp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0xa8(%rsp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0xa0(%rsp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x98(%rsp), %r10
               	movq	%r10, 0x50(%rsp)
               	callq	*%rax
               	addq	$0x60, %rsp
               	cmpq	$0x99, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	leaq	0x10(%rdi), %rsi
               	leaq	0x20(%rdi), %rdx
               	leaq	0x30(%rdi), %rcx
               	leaq	0x40(%rdi), %r8
               	leaq	0x50(%rdi), %r9
               	leaq	0x60(%rdi), %rax
               	leaq	0x70(%rdi), %r12
               	leaq	0x80(%rdi), %r13
               	leaq	0x90(%rdi), %r14
               	leaq	0xa0(%rdi), %r15
               	leaq	0xb0(%rdi), %r10
               	movq	%r10, 0x68(%rsp)
               	leaq	0xc0(%rdi), %r10
               	movq	%r10, 0x60(%rsp)
               	leaq	0xd0(%rdi), %r10
               	movq	%r10, 0x58(%rsp)
               	leaq	0xe0(%rdi), %r10
               	movq	%r10, 0x50(%rsp)
               	leaq	0xf0(%rdi), %r10
               	movq	%r10, 0x48(%rsp)
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	subq	$0xd0, %rsp
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	%r8, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%r12, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	%r13, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x50(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x58(%rsp)
               	movq	%r14, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x60(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x68(%rsp)
               	movq	%r15, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x70(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x78(%rsp)
               	movq	0x148(%rsp), %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x80(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x88(%rsp)
               	movq	0x140(%rsp), %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x90(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x98(%rsp)
               	movq	0x138(%rsp), %r10
               	movq	(%r10), %r11
               	movq	%r11, 0xa0(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0xa8(%rsp)
               	movq	0x130(%rsp), %r10
               	movq	(%r10), %r11
               	movq	%r11, 0xb0(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0xb8(%rsp)
               	movq	0x128(%rsp), %r10
               	movq	(%r10), %r11
               	movq	%r11, 0xc0(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0xc8(%rsp)
               	movq	%rdx, %r8
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	movq	0x8(%r8), %r9
               	movq	(%r8), %r8
               	movq	0xd0(%rsp), %r10
               	callq	*%r10
               	addq	$0xd0, %rsp
               	addq	$0x10, %rsp
               	cmpq	$0x168, %rax            # imm = 0x168
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
