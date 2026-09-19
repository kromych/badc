
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
               	subq	$0x78, %rsp
               	pushq	%r12
               	pushq	%rbx
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
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
               	movq	-0x8(%rbp), %rbx
               	movq	-0x10(%rbp), %r12
               	movq	-0x18(%rbp), %r13
               	movq	-0x20(%rbp), %r14
               	movq	-0x28(%rbp), %r15
               	addq	$0x1, %rbx
               	addq	$0x2, %r12
               	addq	$0x3, %r13
               	addq	$0x4, %r14
               	addq	$0x5, %r15
               	movq	%rbx, -0x8(%rbp)
               	movq	%r12, -0x10(%rbp)
               	movq	%r13, -0x18(%rbp)
               	movq	%r14, -0x20(%rbp)
               	movq	%r15, -0x28(%rbp)
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
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	popq	%rbx
               	popq	%r12
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
               	movq	-0x8(%rbp), %rax
               	movq	-0x10(%rbp), %rbx
               	movq	-0x18(%rbp), %rcx
               	movq	-0x20(%rbp), %rdx
               	movq	-0x28(%rbp), %rsi
               	movq	-0x30(%rbp), %rdi
               	movq	-0x38(%rbp), %r8
               	movq	-0x40(%rbp), %r9
               	movq	-0x48(%rbp), %r12
               	addq	$0x1, %rax
               	addq	$0x1, %rbx
               	addq	$0x1, %rcx
               	addq	$0x1, %rdx
               	addq	$0x1, %rsi
               	addq	$0x1, %rdi
               	addq	$0x1, %r8
               	addq	$0x1, %r9
               	addq	$0x1, %r12
               	movq	%rax, -0x8(%rbp)
               	movq	%rbx, -0x10(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	movq	%rdx, -0x20(%rbp)
               	movq	%rsi, -0x28(%rbp)
               	movq	%rdi, -0x30(%rbp)
               	movq	%r8, -0x38(%rbp)
               	movq	%r9, -0x40(%rbp)
               	movq	%r12, -0x48(%rbp)
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
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x3, %edi
               	leaq	<rip>, %r13
               	movq	(%r13), %rax
               	callq	*%rax
               	movq	%rax, %r14
               	movl	$0x5, %edi
               	movq	(%r13), %rax
               	callq	*%rax
               	movq	%rax, %r15
               	movl	$0x7, %edi
               	movq	(%r13), %rax
               	callq	*%rax
               	movq	%rax, 0x48(%rsp)
               	movl	$0xb, %edi
               	movq	(%r13), %rax
               	callq	*%rax
               	movq	%rax, 0x40(%rsp)
               	movl	$0xd, %edi
               	movq	(%r13), %rax
               	callq	*%rax
               	movq	%rax, 0x38(%rsp)
               	movl	$0x3e8, %eax            # imm = 0x3E8
               	movq	%rax, -0x30(%rbp)
               	movq	-0x30(%rbp), %rbx
               	movl	$0x7d0, %r12d           # imm = 0x7D0
               	addq	%r12, %rbx
               	addq	$0x11, %rbx
               	movq	%rbx, -0x30(%rbp)
               	movq	(%r13), %rax
               	movq	%r14, %rdi
               	callq	*%rax
               	movq	%r15, %rcx
               	shlq	%rcx
               	addq	%rcx, %rax
               	movq	0x48(%rsp), %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	%rcx, %rax
               	movq	0x40(%rsp), %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movq	0x38(%rsp), %rcx
               	leaq	(%rcx,%rcx,4), %rcx
               	addq	%rcx, %rax
               	movq	-0x30(%rbp), %rcx
               	addq	%rcx, %rax
               	addq	$0x7d0, %rax            # imm = 0x7D0
               	cmpq	$0x1428, %rax           # imm = 0x1428
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
