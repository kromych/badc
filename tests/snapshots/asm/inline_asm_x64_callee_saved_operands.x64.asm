
inline_asm_x64_callee_saved_operands.x64:	file format elf64-x86-64

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

<id>:
               	movq	%rdi, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x120, %rsp            # imm = 0x120
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
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
               	movq	%rax, -0xf0(%rbp)
               	movq	%rcx, -0xe8(%rbp)
               	movq	%rdx, -0xe0(%rbp)
               	movq	%rbx, -0xd8(%rbp)
               	movq	%rsi, -0xd0(%rbp)
               	movq	%rdi, -0xc8(%rbp)
               	movq	%r8, -0xc0(%rbp)
               	movq	%r9, -0xb8(%rbp)
               	movq	%r12, -0xb0(%rbp)
               	movq	%r13, -0xa8(%rbp)
               	movq	%r14, -0xa0(%rbp)
               	movq	%r15, -0x98(%rbp)
               	movq	%rax, -0x90(%rbp)
               	movq	%rcx, -0x88(%rbp)
               	movq	%rdx, -0x80(%rbp)
               	movq	%rsi, -0x78(%rbp)
               	movq	%rdi, -0x70(%rbp)
               	movq	-0x90(%rbp), %r10
               	movq	(%r10), %rbx
               	movq	-0x88(%rbp), %r10
               	movq	(%r10), %r12
               	movq	-0x80(%rbp), %r10
               	movq	(%r10), %r13
               	movq	-0x78(%rbp), %r10
               	movq	(%r10), %r14
               	movq	-0x70(%rbp), %r10
               	movq	(%r10), %r15
               	addq	$0x1, %rbx
               	addq	$0x2, %r12
               	addq	$0x3, %r13
               	addq	$0x4, %r14
               	addq	$0x5, %r15
               	movq	-0x90(%rbp), %r10
               	movq	%rbx, (%r10)
               	movq	-0x88(%rbp), %r10
               	movq	%r12, (%r10)
               	movq	-0x80(%rbp), %r10
               	movq	%r13, (%r10)
               	movq	-0x78(%rbp), %r10
               	movq	%r14, (%r10)
               	movq	-0x70(%rbp), %r10
               	movq	%r15, (%r10)
               	movq	-0xf0(%rbp), %rax
               	movq	-0xe8(%rbp), %rcx
               	movq	-0xe0(%rbp), %rdx
               	movq	-0xd8(%rbp), %rbx
               	movq	-0xd0(%rbp), %rsi
               	movq	-0xc8(%rbp), %rdi
               	movq	-0xc0(%rbp), %r8
               	movq	-0xb8(%rbp), %r9
               	movq	-0xb0(%rbp), %r12
               	movq	-0xa8(%rbp), %r13
               	movq	-0xa0(%rbp), %r14
               	movq	-0x98(%rbp), %r15
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
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	movl	$0x1, %eax
               	movq	%rax, -0x8(%rbp)
               	movl	$0x2, %eax
               	movq	%rax, -0x10(%rbp)
               	movl	$0x3, %eax
               	movq	%rax, -0x18(%rbp)
               	movl	$0x4, %eax
               	movq	%rax, -0x20(%rbp)
               	movl	$0x5, %eax
               	movq	%rax, -0x28(%rbp)
               	movl	$0x6, %eax
               	movq	%rax, -0x30(%rbp)
               	movl	$0x7, %eax
               	movq	%rax, -0x38(%rbp)
               	movl	$0x8, %eax
               	movq	%rax, -0x40(%rbp)
               	movl	$0x9, %eax
               	movq	%rax, -0x48(%rbp)
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	leaq	-0x18(%rbp), %rdx
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x28(%rbp), %rdi
               	leaq	-0x30(%rbp), %r8
               	leaq	-0x38(%rbp), %r9
               	leaq	-0x40(%rbp), %rbx
               	leaq	-0x48(%rbp), %r12
               	movq	%rax, -0xf0(%rbp)
               	movq	%rcx, -0xe8(%rbp)
               	movq	%rdx, -0xe0(%rbp)
               	movq	%rbx, -0xd8(%rbp)
               	movq	%rsi, -0xd0(%rbp)
               	movq	%rdi, -0xc8(%rbp)
               	movq	%r8, -0xc0(%rbp)
               	movq	%r9, -0xb8(%rbp)
               	movq	%r12, -0xb0(%rbp)
               	movq	%rax, -0xa8(%rbp)
               	movq	%rcx, -0xa0(%rbp)
               	movq	%rdx, -0x98(%rbp)
               	movq	%rsi, -0x90(%rbp)
               	movq	%rdi, -0x88(%rbp)
               	movq	%r8, -0x80(%rbp)
               	movq	%r9, -0x78(%rbp)
               	movq	%rbx, -0x70(%rbp)
               	movq	%r12, -0x68(%rbp)
               	movq	-0xa8(%rbp), %r10
               	movq	(%r10), %rax
               	movq	-0xa0(%rbp), %r10
               	movq	(%r10), %rbx
               	movq	-0x98(%rbp), %r10
               	movq	(%r10), %rcx
               	movq	-0x90(%rbp), %r10
               	movq	(%r10), %rdx
               	movq	-0x88(%rbp), %r10
               	movq	(%r10), %rsi
               	movq	-0x80(%rbp), %r10
               	movq	(%r10), %rdi
               	movq	-0x78(%rbp), %r10
               	movq	(%r10), %r8
               	movq	-0x70(%rbp), %r10
               	movq	(%r10), %r9
               	movq	-0x68(%rbp), %r10
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
               	movq	-0xa8(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0xa0(%rbp), %r10
               	movq	%rbx, (%r10)
               	movq	-0x98(%rbp), %r10
               	movq	%rcx, (%r10)
               	movq	-0x90(%rbp), %r10
               	movq	%rdx, (%r10)
               	movq	-0x88(%rbp), %r10
               	movq	%rsi, (%r10)
               	movq	-0x80(%rbp), %r10
               	movq	%rdi, (%r10)
               	movq	-0x78(%rbp), %r10
               	movq	%r8, (%r10)
               	movq	-0x70(%rbp), %r10
               	movq	%r9, (%r10)
               	movq	-0x68(%rbp), %r10
               	movq	%r12, (%r10)
               	movq	-0xf0(%rbp), %rax
               	movq	-0xe8(%rbp), %rcx
               	movq	-0xe0(%rbp), %rdx
               	movq	-0xd8(%rbp), %rbx
               	movq	-0xd0(%rbp), %rsi
               	movq	-0xc8(%rbp), %rdi
               	movq	-0xc0(%rbp), %r8
               	movq	-0xb8(%rbp), %r9
               	movq	-0xb0(%rbp), %r12
               	movq	-0x8(%rbp), %rax
               	movq	-0x10(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x18(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x20(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x28(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x30(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x38(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x40(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x48(%rbp), %rcx
               	addq	%rcx, %rax
               	cmpq	$0x36, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	movl	$0x3, %edi
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rax
               	callq	*%rax
               	movq	%rax, %r12
               	movl	$0x5, %edi
               	movq	(%rbx), %rax
               	callq	*%rax
               	movq	%rax, %r13
               	movl	$0x7, %edi
               	movq	(%rbx), %rax
               	callq	*%rax
               	movq	%rax, %r14
               	movl	$0xb, %edi
               	movq	(%rbx), %rax
               	callq	*%rax
               	movq	%rax, %r15
               	movl	$0xd, %edi
               	movq	(%rbx), %rax
               	callq	*%rax
               	movq	%rax, 0xc8(%rsp)
               	movl	$0x3e8, %eax            # imm = 0x3E8
               	movq	%rax, -0x30(%rbp)
               	movl	$0x7d0, %eax            # imm = 0x7D0
               	leaq	-0x30(%rbp), %rcx
               	movq	%rax, -0xf0(%rbp)
               	movq	%rcx, -0xe8(%rbp)
               	movq	%rdx, -0xe0(%rbp)
               	movq	%rbx, -0xd8(%rbp)
               	movq	%rsi, -0xd0(%rbp)
               	movq	%rdi, -0xc8(%rbp)
               	movq	%r8, -0xc0(%rbp)
               	movq	%r9, -0xb8(%rbp)
               	movq	%r12, -0xb0(%rbp)
               	movq	%rcx, -0xa8(%rbp)
               	movq	%rax, -0xa0(%rbp)
               	movq	-0xa8(%rbp), %r10
               	movq	(%r10), %rbx
               	movq	-0xa0(%rbp), %r12
               	addq	%r12, %rbx
               	addq	$0x11, %rbx
               	movq	-0xa8(%rbp), %r10
               	movq	%rbx, (%r10)
               	movq	-0xf0(%rbp), %rax
               	movq	-0xe8(%rbp), %rcx
               	movq	-0xe0(%rbp), %rdx
               	movq	-0xd8(%rbp), %rbx
               	movq	-0xd0(%rbp), %rsi
               	movq	-0xc8(%rbp), %rdi
               	movq	-0xc0(%rbp), %r8
               	movq	-0xb8(%rbp), %r9
               	movq	-0xb0(%rbp), %r12
               	movq	(%rbx), %rax
               	movq	%r12, %rdi
               	callq	*%rax
               	movq	%r13, %rcx
               	shlq	%rcx
               	addq	%rcx, %rax
               	leaq	(%r14,%r14,2), %rcx
               	addq	%rcx, %rax
               	movq	%r15, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movq	0xc8(%rsp), %rcx
               	leaq	(%rcx,%rcx,4), %rcx
               	addq	%rcx, %rax
               	movq	-0x30(%rbp), %rcx
               	addq	%rcx, %rax
               	addq	$0x7d0, %rax            # imm = 0x7D0
               	cmpq	$0x1428, %rax           # imm = 0x1428
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
