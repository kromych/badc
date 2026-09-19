
sroa_const_index_local_array.x64:	file format elf64-x86-64

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

<rounds>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	movq	(%rbx), %rax
               	movq	0x8(%rbx), %rcx
               	movq	0x10(%rbx), %rdx
               	movq	0x18(%rbx), %r8
               	movq	0x20(%rbx), %r9
               	movq	0x28(%rbx), %rsi
               	movq	0x30(%rbx), %rdi
               	movq	0x38(%rbx), %rbx
               	leaq	-0x1(%r12), %r13
               	testl	%r12d, %r12d
               	jle	<addr>
               	movq	%rbx, %r12
               	shlq	%r12
               	addq	%rdi, %r12
               	shlq	%rdi
               	addq	%rsi, %rdi
               	shlq	%rsi
               	addq	%r9, %rsi
               	shlq	%r9
               	addq	%r8, %r9
               	shlq	%r8
               	addq	%rdx, %r8
               	shlq	%rdx
               	addq	%rcx, %rdx
               	shlq	%rcx
               	addq	%rax, %rcx
               	shlq	%rax
               	xorq	%rbx, %rax
               	movq	%r12, %rbx
               	movq	%r13, %r12
               	leaq	-0x1(%r12), %r13
               	testl	%r12d, %r12d
               	jg	<addr>
               	addq	%rcx, %rax
               	addq	%rdx, %rax
               	addq	%r8, %rax
               	addq	%r9, %rax
               	addq	%rsi, %rax
               	addq	%rdi, %rax
               	addq	%rbx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	-0x40(%rbp), %rax
               	movq	$0x7, (%rax)
               	movq	$0x1118, 0x8(%rax)      # imm = 0x1118
               	movq	$0x2229, 0x10(%rax)     # imm = 0x2229
               	movq	$0x333a, 0x18(%rax)     # imm = 0x333A
               	movq	$0x444b, 0x20(%rax)     # imm = 0x444B
               	movq	$0x555c, 0x28(%rax)     # imm = 0x555C
               	movq	$0x666d, 0x30(%rax)     # imm = 0x666D
               	leaq	-0x40(%rbp), %rdi
               	movq	$0x777e, 0x38(%rdi)     # imm = 0x777E
               	movl	$0x5, %esi
               	callq	<addr>
               	cmpq	$0x14ebf84, %rax        # imm = 0x14EBF84
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
