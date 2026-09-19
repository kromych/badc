
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
               	movq	%rdi, %r12
               	movq	%rsi, %rbx
               	movq	(%r12), %rax
               	movq	0x8(%r12), %rcx
               	movq	0x10(%r12), %rdx
               	movq	0x18(%r12), %rsi
               	movq	0x20(%r12), %rdi
               	movq	0x28(%r12), %r8
               	movq	0x30(%r12), %r9
               	movq	0x38(%r12), %r12
               	leaq	-0x1(%rbx), %r13
               	testl	%ebx, %ebx
               	jle	<addr>
               	movq	%r12, %rbx
               	shlq	%rbx
               	addq	%r9, %rbx
               	shlq	%r9
               	addq	%r8, %r9
               	shlq	%r8
               	addq	%rdi, %r8
               	shlq	%rdi
               	addq	%rsi, %rdi
               	shlq	%rsi
               	addq	%rdx, %rsi
               	shlq	%rdx
               	addq	%rcx, %rdx
               	shlq	%rcx
               	addq	%rax, %rcx
               	shlq	%rax
               	xorq	%r12, %rax
               	movq	%rbx, %r12
               	movq	%r13, %rbx
               	leaq	-0x1(%rbx), %r13
               	testl	%ebx, %ebx
               	jg	<addr>
               	addq	%rcx, %rax
               	addq	%rdx, %rax
               	addq	%rsi, %rax
               	addq	%rdi, %rax
               	addq	%r8, %rax
               	addq	%r9, %rax
               	addq	%r12, %rax
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
