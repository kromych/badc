
inline_asm_x64_callee_saved_preserved.x64:	file format elf64-x86-64

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

<clobber_heavy>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xc0, %rsp
               	movl	$0xa, %eax
               	movq	%rax, -0x8(%rbp)
               	movl	$0x14, %eax
               	movq	%rax, -0x10(%rbp)
               	movl	$0x1e, %eax
               	movq	%rax, -0x18(%rbp)
               	movl	$0x28, %eax
               	movq	%rax, -0x20(%rbp)
               	movl	$0x32, %eax
               	movq	%rax, -0x28(%rbp)
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	leaq	-0x18(%rbp), %rdx
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x28(%rbp), %rdi
               	movq	%rax, -0xc0(%rbp)
               	movq	%rcx, -0xb8(%rbp)
               	movq	%rdx, -0xb0(%rbp)
               	movq	%rbx, -0xa8(%rbp)
               	movq	%rsi, -0xa0(%rbp)
               	movq	%rdi, -0x98(%rbp)
               	movq	%r8, -0x90(%rbp)
               	movq	%r9, -0x88(%rbp)
               	movq	%r12, -0x80(%rbp)
               	movq	%r13, -0x78(%rbp)
               	movq	%r14, -0x70(%rbp)
               	movq	%r15, -0x68(%rbp)
               	movq	%rax, -0x60(%rbp)
               	movq	%rcx, -0x58(%rbp)
               	movq	%rdx, -0x50(%rbp)
               	movq	%rsi, -0x48(%rbp)
               	movq	%rdi, -0x40(%rbp)
               	movq	-0x60(%rbp), %r10
               	movq	(%r10), %rbx
               	movq	-0x58(%rbp), %r10
               	movq	(%r10), %r12
               	movq	-0x50(%rbp), %r10
               	movq	(%r10), %r13
               	movq	-0x48(%rbp), %r10
               	movq	(%r10), %r14
               	movq	-0x40(%rbp), %r10
               	movq	(%r10), %r15
               	addq	$0x1, %rbx
               	addq	$0x2, %r12
               	addq	$0x3, %r13
               	addq	$0x4, %r14
               	addq	$0x5, %r15
               	movq	-0x60(%rbp), %r10
               	movq	%rbx, (%r10)
               	movq	-0x58(%rbp), %r10
               	movq	%r12, (%r10)
               	movq	-0x50(%rbp), %r10
               	movq	%r13, (%r10)
               	movq	-0x48(%rbp), %r10
               	movq	%r14, (%r10)
               	movq	-0x40(%rbp), %r10
               	movq	%r15, (%r10)
               	movq	-0xc0(%rbp), %rax
               	movq	-0xb8(%rbp), %rcx
               	movq	-0xb0(%rbp), %rdx
               	movq	-0xa8(%rbp), %rbx
               	movq	-0xa0(%rbp), %rsi
               	movq	-0x98(%rbp), %rdi
               	movq	-0x90(%rbp), %r8
               	movq	-0x88(%rbp), %r9
               	movq	-0x80(%rbp), %r12
               	movq	-0x78(%rbp), %r13
               	movq	-0x70(%rbp), %r14
               	movq	-0x68(%rbp), %r15
               	movq	-0x8(%rbp), %rax
               	movq	-0x10(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x18(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x20(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x28(%rbp), %rcx
               	addq	%rcx, %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xc0, %rsp
               	movl	$0xa, %eax
               	movq	%rax, -0x10(%rbp)
               	movl	$0x14, %eax
               	movq	%rax, -0x18(%rbp)
               	movl	$0x1e, %eax
               	movq	%rax, -0x20(%rbp)
               	movl	$0x28, %eax
               	movq	%rax, -0x28(%rbp)
               	movl	$0x32, %eax
               	movq	%rax, -0x30(%rbp)
               	leaq	-0x10(%rbp), %rax
               	leaq	-0x18(%rbp), %rcx
               	leaq	-0x20(%rbp), %rdx
               	leaq	-0x28(%rbp), %rsi
               	leaq	-0x30(%rbp), %rdi
               	movq	%rax, -0xc0(%rbp)
               	movq	%rcx, -0xb8(%rbp)
               	movq	%rdx, -0xb0(%rbp)
               	movq	%rbx, -0xa8(%rbp)
               	movq	%rsi, -0xa0(%rbp)
               	movq	%rdi, -0x98(%rbp)
               	movq	%r8, -0x90(%rbp)
               	movq	%r9, -0x88(%rbp)
               	movq	%r12, -0x80(%rbp)
               	movq	%r13, -0x78(%rbp)
               	movq	%r14, -0x70(%rbp)
               	movq	%r15, -0x68(%rbp)
               	movq	%rax, -0x60(%rbp)
               	movq	%rcx, -0x58(%rbp)
               	movq	%rdx, -0x50(%rbp)
               	movq	%rsi, -0x48(%rbp)
               	movq	%rdi, -0x40(%rbp)
               	movq	-0x60(%rbp), %r10
               	movq	(%r10), %rbx
               	movq	-0x58(%rbp), %r10
               	movq	(%r10), %r12
               	movq	-0x50(%rbp), %r10
               	movq	(%r10), %r13
               	movq	-0x48(%rbp), %r10
               	movq	(%r10), %r14
               	movq	-0x40(%rbp), %r10
               	movq	(%r10), %r15
               	addq	$0x1, %rbx
               	addq	$0x2, %r12
               	addq	$0x3, %r13
               	addq	$0x4, %r14
               	addq	$0x5, %r15
               	movq	-0x60(%rbp), %r10
               	movq	%rbx, (%r10)
               	movq	-0x58(%rbp), %r10
               	movq	%r12, (%r10)
               	movq	-0x50(%rbp), %r10
               	movq	%r13, (%r10)
               	movq	-0x48(%rbp), %r10
               	movq	%r14, (%r10)
               	movq	-0x40(%rbp), %r10
               	movq	%r15, (%r10)
               	movq	-0xc0(%rbp), %rax
               	movq	-0xb8(%rbp), %rcx
               	movq	-0xb0(%rbp), %rdx
               	movq	-0xa8(%rbp), %rbx
               	movq	-0xa0(%rbp), %rsi
               	movq	-0x98(%rbp), %rdi
               	movq	-0x90(%rbp), %r8
               	movq	-0x88(%rbp), %r9
               	movq	-0x80(%rbp), %r12
               	movq	-0x78(%rbp), %r13
               	movq	-0x70(%rbp), %r14
               	movq	-0x68(%rbp), %r15
               	movq	-0x10(%rbp), %rax
               	movq	-0x18(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x20(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x28(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x30(%rbp), %rcx
               	addq	%rcx, %rax
               	cmpq	$0xa5, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, -0xc0(%rbp)
               	movq	%rcx, -0xb8(%rbp)
               	movq	%rdx, -0xb0(%rbp)
               	movq	%rbx, -0xa8(%rbp)
               	movq	%rsi, -0xa0(%rbp)
               	movq	%rdi, -0x98(%rbp)
               	movq	%r8, -0x90(%rbp)
               	movq	%r9, -0x88(%rbp)
               	movq	%r10, -0x80(%rbp)
               	movq	%r11, -0x78(%rbp)
               	movq	%r12, -0x70(%rbp)
               	movq	%r13, -0x68(%rbp)
               	movq	%r14, -0x60(%rbp)
               	movq	%r15, -0x58(%rbp)
               	movq	%rax, -0x50(%rbp)
               	movq	$0x65, %rbx
               	movq	$0x67, %r12
               	movq	$0x6b, %r13
               	movq	$0x6d, %r14
               	movq	$0x71, %r15
               	callq	<addr>
               	movq	%rax, %r9
               	addq	%r9, %r9
               	addq	%rbx, %r9
               	addq	%r9, %r9
               	addq	%r12, %r9
               	addq	%r9, %r9
               	addq	%r13, %r9
               	addq	%r9, %r9
               	addq	%r14, %r9
               	addq	%r9, %r9
               	addq	%r15, %r9
               	movq	-0x50(%rbp), %r10
               	movq	%r9, (%r10)
               	movq	-0xc0(%rbp), %rax
               	movq	-0xb8(%rbp), %rcx
               	movq	-0xb0(%rbp), %rdx
               	movq	-0xa8(%rbp), %rbx
               	movq	-0xa0(%rbp), %rsi
               	movq	-0x98(%rbp), %rdi
               	movq	-0x90(%rbp), %r8
               	movq	-0x88(%rbp), %r9
               	movq	-0x80(%rbp), %r10
               	movq	-0x78(%rbp), %r11
               	movq	-0x70(%rbp), %r12
               	movq	-0x68(%rbp), %r13
               	movq	-0x60(%rbp), %r14
               	movq	-0x58(%rbp), %r15
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x211f, %rax           # imm = 0x211F
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	leave
               	retq
