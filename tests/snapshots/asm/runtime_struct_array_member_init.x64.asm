
runtime_struct_array_member_init.x64:	file format elf64-x86-64

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
               	subq	$0xb0, %rsp
               	leaq	-0xa8(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, 0x10(%rax)
               	movq	%rcx, 0x18(%rax)
               	movq	%rcx, 0x20(%rax)
               	movq	%rcx, 0x28(%rax)
               	movq	%rcx, 0x30(%rax)
               	movq	%rcx, 0x38(%rax)
               	movq	%rcx, 0x40(%rax)
               	movq	%rcx, 0x48(%rax)
               	movq	%rcx, 0x50(%rax)
               	movq	%rcx, 0x58(%rax)
               	movq	%rcx, 0x60(%rax)
               	movq	%rcx, 0x68(%rax)
               	movq	%rcx, 0x70(%rax)
               	movq	%rcx, 0x78(%rax)
               	movq	%rcx, 0x80(%rax)
               	movq	%rcx, 0x88(%rax)
               	movq	%rcx, 0x90(%rax)
               	movq	%rcx, 0x98(%rax)
               	movq	%rcx, 0xa0(%rax)
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	<rip>, %rcx
               	movq	%rcx, 0x10(%rax)
               	movl	$0x1000, %edx           # imm = 0x1000
               	movq	%rdx, 0x18(%rax)
               	movl	$0x1, %edx
               	movl	%edx, 0x20(%rax)
               	movl	$0x2, %edi
               	movl	%edi, 0x24(%rax)
               	movl	$0x3, %edx
               	leaq	-0xa8(%rbp), %rax
               	movl	%edx, 0x28(%rax)
               	leaq	<rip>, %rdx
               	movq	%rdx, 0x30(%rax)
               	leaq	0x8(%rcx), %rdx
               	movq	%rdx, 0x38(%rax)
               	movl	$0x2000, %esi           # imm = 0x2000
               	movq	%rsi, 0x40(%rax)
               	movslq	(%rcx), %rsi
               	cmpl	$0xa, %esi
               	je	<addr>
               	movq	%rdi, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	movq	%rdi, %rsi
               	cmpq	%rdx, %rdx
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	movslq	(%rdx), %rcx
               	cmpl	$0x1e, %ecx
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	movslq	0x48(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	movq	%rdi, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
