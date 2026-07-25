
inline_asm_x64_callee_saved_operands.x64:	file format elf64-x86-64

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
               	subq	$0x110, %rsp            # imm = 0x110
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
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
               	movq	%rax, -0x100(%rbp)
               	movq	%rcx, -0xf8(%rbp)
               	movq	%rdx, -0xf0(%rbp)
               	movq	%rbx, -0xe8(%rbp)
               	movq	%rsi, -0xe0(%rbp)
               	movq	%rdi, -0xd8(%rbp)
               	movq	%r8, -0xd0(%rbp)
               	movq	%r9, -0xc8(%rbp)
               	movq	%r12, -0xc0(%rbp)
               	movq	%r13, -0xb8(%rbp)
               	movq	%r14, -0xb0(%rbp)
               	movq	%r15, -0xa8(%rbp)
               	movq	%rax, -0xa0(%rbp)
               	movq	%rcx, -0x98(%rbp)
               	movq	%rdx, -0x90(%rbp)
               	movq	%rsi, -0x88(%rbp)
               	movq	%rdi, -0x80(%rbp)
               	movq	-0xa0(%rbp), %r10
               	movq	(%r10), %rbx
               	movq	-0x98(%rbp), %r10
               	movq	(%r10), %r12
               	movq	-0x90(%rbp), %r10
               	movq	(%r10), %r13
               	movq	-0x88(%rbp), %r10
               	movq	(%r10), %r14
               	movq	-0x80(%rbp), %r10
               	movq	(%r10), %r15
               	addq	$0x1, %rbx
               	addq	$0x2, %r12
               	addq	$0x3, %r13
               	addq	$0x4, %r14
               	addq	$0x5, %r15
               	movq	-0xa0(%rbp), %r10
               	movq	%rbx, (%r10)
               	movq	-0x98(%rbp), %r10
               	movq	%r12, (%r10)
               	movq	-0x90(%rbp), %r10
               	movq	%r13, (%r10)
               	movq	-0x88(%rbp), %r10
               	movq	%r14, (%r10)
               	movq	-0x80(%rbp), %r10
               	movq	%r15, (%r10)
               	movq	-0x100(%rbp), %rax
               	movq	-0xf8(%rbp), %rcx
               	movq	-0xf0(%rbp), %rdx
               	movq	-0xe8(%rbp), %rbx
               	movq	-0xe0(%rbp), %rsi
               	movq	-0xd8(%rbp), %rdi
               	movq	-0xd0(%rbp), %r8
               	movq	-0xc8(%rbp), %r9
               	movq	-0xc0(%rbp), %r12
               	movq	-0xb8(%rbp), %r13
               	movq	-0xb0(%rbp), %r14
               	movq	-0xa8(%rbp), %r15
               	movq	-0x8(%rbp), %rax
               	movq	-0x10(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x18(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x20(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x28(%rbp), %rcx
               	addq	%rcx, %rax
               	cmpq	$0xa5, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	movq	%rax, -0x30(%rbp)
               	movl	$0x2, %eax
               	movq	%rax, -0x38(%rbp)
               	movl	$0x3, %eax
               	movq	%rax, -0x40(%rbp)
               	movl	$0x4, %eax
               	movq	%rax, -0x48(%rbp)
               	movl	$0x5, %eax
               	movq	%rax, -0x50(%rbp)
               	movl	$0x6, %eax
               	movq	%rax, -0x58(%rbp)
               	movl	$0x7, %eax
               	movq	%rax, -0x60(%rbp)
               	movl	$0x8, %eax
               	movq	%rax, -0x68(%rbp)
               	movl	$0x9, %eax
               	movq	%rax, -0x70(%rbp)
               	leaq	-0x30(%rbp), %rax
               	leaq	-0x38(%rbp), %rcx
               	leaq	-0x40(%rbp), %rdx
               	leaq	-0x48(%rbp), %rsi
               	leaq	-0x50(%rbp), %rdi
               	leaq	-0x58(%rbp), %r8
               	leaq	-0x60(%rbp), %r9
               	leaq	-0x68(%rbp), %rbx
               	leaq	-0x70(%rbp), %r12
               	movq	%rax, -0x100(%rbp)
               	movq	%rcx, -0xf8(%rbp)
               	movq	%rdx, -0xf0(%rbp)
               	movq	%rbx, -0xe8(%rbp)
               	movq	%rsi, -0xe0(%rbp)
               	movq	%rdi, -0xd8(%rbp)
               	movq	%r8, -0xd0(%rbp)
               	movq	%r9, -0xc8(%rbp)
               	movq	%r12, -0xc0(%rbp)
               	movq	%rax, -0xb8(%rbp)
               	movq	%rcx, -0xb0(%rbp)
               	movq	%rdx, -0xa8(%rbp)
               	movq	%rsi, -0xa0(%rbp)
               	movq	%rdi, -0x98(%rbp)
               	movq	%r8, -0x90(%rbp)
               	movq	%r9, -0x88(%rbp)
               	movq	%rbx, -0x80(%rbp)
               	movq	%r12, -0x78(%rbp)
               	movq	-0xb8(%rbp), %r10
               	movq	(%r10), %rax
               	movq	-0xb0(%rbp), %r10
               	movq	(%r10), %rbx
               	movq	-0xa8(%rbp), %r10
               	movq	(%r10), %rcx
               	movq	-0xa0(%rbp), %r10
               	movq	(%r10), %rdx
               	movq	-0x98(%rbp), %r10
               	movq	(%r10), %rsi
               	movq	-0x90(%rbp), %r10
               	movq	(%r10), %rdi
               	movq	-0x88(%rbp), %r10
               	movq	(%r10), %r8
               	movq	-0x80(%rbp), %r10
               	movq	(%r10), %r9
               	movq	-0x78(%rbp), %r10
               	movq	(%r10), %r12
               	addq	$0x1, %rax
               	addq	$0x1, %rbx
               	addq	$0x1, %rcx
               	addq	$0x1, %rdx
               	addq	$0x1, %rsi
               	addq	$0x1, %rdi
               	addq	$0x1, %r8
               	addq	$0x1, %r9
               	addq	$0x1, %r12
               	movq	-0xb8(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0xb0(%rbp), %r10
               	movq	%rbx, (%r10)
               	movq	-0xa8(%rbp), %r10
               	movq	%rcx, (%r10)
               	movq	-0xa0(%rbp), %r10
               	movq	%rdx, (%r10)
               	movq	-0x98(%rbp), %r10
               	movq	%rsi, (%r10)
               	movq	-0x90(%rbp), %r10
               	movq	%rdi, (%r10)
               	movq	-0x88(%rbp), %r10
               	movq	%r8, (%r10)
               	movq	-0x80(%rbp), %r10
               	movq	%r9, (%r10)
               	movq	-0x78(%rbp), %r10
               	movq	%r12, (%r10)
               	movq	-0x100(%rbp), %rax
               	movq	-0xf8(%rbp), %rcx
               	movq	-0xf0(%rbp), %rdx
               	movq	-0xe8(%rbp), %rbx
               	movq	-0xe0(%rbp), %rsi
               	movq	-0xd8(%rbp), %rdi
               	movq	-0xd0(%rbp), %r8
               	movq	-0xc8(%rbp), %r9
               	movq	-0xc0(%rbp), %r12
               	movq	-0x30(%rbp), %rax
               	movq	-0x38(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x40(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x48(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x50(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x58(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x60(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x68(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x70(%rbp), %rcx
               	addq	%rcx, %rax
               	cmpq	$0x36, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	jmp	<addr>
