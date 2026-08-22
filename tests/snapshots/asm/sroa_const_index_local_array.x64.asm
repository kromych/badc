
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
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%rdi, %r12
               	movq	%rsi, %rbx
               	leaq	(%r12), %rax
               	movq	(%rax), %rax
               	movq	0x8(%r12), %rcx
               	movq	0x10(%r12), %rdx
               	movq	0x18(%r12), %rsi
               	movq	0x20(%r12), %rdi
               	movq	0x28(%r12), %r8
               	movq	0x30(%r12), %r9
               	movq	0x38(%r12), %r12
               	jmp	<addr>
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
               	addq	$0x0, %rax
               	addq	%rcx, %rax
               	addq	%rdx, %rax
               	addq	%rsi, %rax
               	addq	%rdi, %rax
               	addq	%r8, %rax
               	addq	%r9, %rax
               	addq	%r12, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	-0x40(%rbp), %rax
               	leaq	(%rax), %rcx
               	movl	$0x7, %edx
               	movq	%rdx, (%rcx)
               	movl	$0x1118, %ecx           # imm = 0x1118
               	movq	%rcx, 0x8(%rax)
               	movl	$0x2229, %ecx           # imm = 0x2229
               	movq	%rcx, 0x10(%rax)
               	movl	$0x333a, %ecx           # imm = 0x333A
               	movq	%rcx, 0x18(%rax)
               	movl	$0x444b, %ecx           # imm = 0x444B
               	movq	%rcx, 0x20(%rax)
               	movl	$0x555c, %ecx           # imm = 0x555C
               	movq	%rcx, 0x28(%rax)
               	movl	$0x666d, %ecx           # imm = 0x666D
               	movq	%rcx, 0x30(%rax)
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x777e, %eax           # imm = 0x777E
               	movq	%rax, 0x38(%rdi)
               	movl	$0x5, %esi
               	callq	<addr>
               	cmpq	$0x14ebf84, %rax        # imm = 0x14EBF84
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
