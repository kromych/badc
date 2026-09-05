
inline_asm_reg_var_inout.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movl	$0x4, %eax
               	leaq	-0x28(%rbp), %rcx
               	movq	%rax, -0xb0(%rbp)
               	movq	%rcx, -0xa8(%rbp)
               	movq	%rax, -0xa0(%rbp)
               	movq	-0xa0(%rbp), %rax
               	addq	$0x1, %rax
               	movq	-0xa8(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0xb0(%rbp), %rax
               	movq	-0x28(%rbp), %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movl	$0x1, %eax
               	movl	$0x2, %ecx
               	movl	$0x3, %edx
               	movl	$0x4, %esi
               	movl	$0x5, %edi
               	movl	$0x6, %r8d
               	leaq	-0x20(%rbp), %r9
               	leaq	-0x18(%rbp), %rbx
               	leaq	-0x10(%rbp), %r12
               	leaq	-0x8(%rbp), %r13
               	movq	%rax, -0xb0(%rbp)
               	movq	%rcx, -0xa8(%rbp)
               	movq	%rdx, -0xa0(%rbp)
               	movq	%rsi, -0x98(%rbp)
               	movq	%r8, -0x90(%rbp)
               	movq	%r9, -0x88(%rbp)
               	movq	%r9, -0x80(%rbp)
               	movq	%rbx, -0x78(%rbp)
               	movq	%r12, -0x70(%rbp)
               	movq	%r13, -0x68(%rbp)
               	movq	%rax, -0x60(%rbp)
               	movq	%rcx, -0x58(%rbp)
               	movq	%rdx, -0x50(%rbp)
               	movq	%rsi, -0x48(%rbp)
               	movq	%rdi, -0x40(%rbp)
               	movq	%r8, -0x38(%rbp)
               	movq	-0x60(%rbp), %rax
               	movq	-0x58(%rbp), %rcx
               	movq	-0x50(%rbp), %rdx
               	movq	-0x48(%rbp), %rsi
               	movq	-0x40(%rbp), %r8
               	movq	-0x38(%rbp), %r9
               	addq	%r8, %rax
               	addq	%r9, %rcx
               	addq	$0x2, %rdx
               	addq	$0x3, %rsi
               	movq	-0x80(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x78(%rbp), %r10
               	movq	%rcx, (%r10)
               	movq	-0x70(%rbp), %r10
               	movq	%rdx, (%r10)
               	movq	-0x68(%rbp), %r10
               	movq	%rsi, (%r10)
               	movq	-0xb0(%rbp), %rax
               	movq	-0xa8(%rbp), %rcx
               	movq	-0xa0(%rbp), %rdx
               	movq	-0x98(%rbp), %rsi
               	movq	-0x90(%rbp), %r8
               	movq	-0x88(%rbp), %r9
               	movq	-0x20(%rbp), %rax
               	movq	-0x18(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x10(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x8(%rbp), %rcx
               	addq	%rcx, %rax
               	cmpq	$0x1a, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movl	$0x2a, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
