
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
               	subq	$0x38, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	$0xa, -0x8(%rbp)
               	movq	$0x14, -0x10(%rbp)
               	movq	$0x1e, -0x18(%rbp)
               	movq	$0x28, -0x20(%rbp)
               	movq	$0x32, -0x28(%rbp)
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
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
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
               	movq	$0xa, -0x10(%rbp)
               	movq	$0x14, -0x18(%rbp)
               	movq	$0x1e, -0x20(%rbp)
               	movq	$0x28, -0x28(%rbp)
               	movq	$0x32, -0x30(%rbp)
               	movq	-0x10(%rbp), %rbx
               	movq	-0x18(%rbp), %r12
               	movq	-0x20(%rbp), %r13
               	movq	-0x28(%rbp), %r14
               	movq	-0x30(%rbp), %r15
               	addq	$0x1, %rbx
               	addq	$0x2, %r12
               	addq	$0x3, %r13
               	addq	$0x4, %r14
               	addq	$0x5, %r15
               	movq	%rbx, -0x10(%rbp)
               	movq	%r12, -0x18(%rbp)
               	movq	%r13, -0x20(%rbp)
               	movq	%r14, -0x28(%rbp)
               	movq	%r15, -0x30(%rbp)
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
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
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
               	movq	%r9, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x211f, %rax           # imm = 0x211F
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
