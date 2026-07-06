
sroa_const_index_local_array.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<rounds>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%rsi, %r13
               	leaq	(%rdi), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rdi), %rdx
               	movq	0x10(%rdi), %rsi
               	movq	0x18(%rdi), %r8
               	movq	0x20(%rdi), %r9
               	movq	0x28(%rdi), %rbx
               	movq	0x30(%rdi), %r12
               	movq	0x38(%rdi), %rdi
               	jmp	<addr>
               	movq	%rdi, %rax
               	shlq	$0x1, %rax
               	addq	%r12, %rax
               	shlq	$0x1, %r12
               	addq	%rbx, %r12
               	shlq	$0x1, %rbx
               	addq	%r9, %rbx
               	shlq	$0x1, %r9
               	addq	%r8, %r9
               	shlq	$0x1, %r8
               	addq	%rsi, %r8
               	shlq	$0x1, %rsi
               	addq	%rdx, %rsi
               	shlq	$0x1, %rdx
               	addq	%rcx, %rdx
               	shlq	$0x1, %rcx
               	xorq	%rdi, %rcx
               	movq	%rax, %rdi
               	movslq	%r13d, %rax
               	leaq	-0x1(%rax), %r13
               	testq	%rax, %rax
               	jg	<addr>
               	leaq	(%rcx), %rax
               	addq	%rdx, %rax
               	addq	%rsi, %rax
               	addq	%r8, %rax
               	addq	%r9, %rax
               	addq	%rbx, %rax
               	addq	%r12, %rax
               	addq	%rdi, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	leaq	-0x40(%rbp), %rax
               	addq	$0x0, %rax
               	movl	$0x7, %ecx
               	movq	%rcx, (%rax)
               	leaq	-0x40(%rbp), %rax
               	movl	$0x1118, %ecx           # imm = 0x1118
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x40(%rbp), %rax
               	movl	$0x2229, %ecx           # imm = 0x2229
               	movq	%rcx, 0x10(%rax)
               	leaq	-0x40(%rbp), %rax
               	movl	$0x333a, %ecx           # imm = 0x333A
               	movq	%rcx, 0x18(%rax)
               	leaq	-0x40(%rbp), %rax
               	movl	$0x444b, %ecx           # imm = 0x444B
               	movq	%rcx, 0x20(%rax)
               	leaq	-0x40(%rbp), %rax
               	movl	$0x555c, %ecx           # imm = 0x555C
               	movq	%rcx, 0x28(%rax)
               	leaq	-0x40(%rbp), %rax
               	movl	$0x666d, %ecx           # imm = 0x666D
               	movq	%rcx, 0x30(%rax)
               	leaq	-0x40(%rbp), %rax
               	movl	$0x777e, %ecx           # imm = 0x777E
               	movq	%rcx, 0x38(%rax)
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x5, %esi
               	callq	<addr>
               	cmpq	$0x14ebf84, %rax        # imm = 0x14EBF84
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
