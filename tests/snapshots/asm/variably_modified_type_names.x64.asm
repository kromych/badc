
variably_modified_type_names.x64:	file format elf64-x86-64

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
               	subq	$0x30, %rsp
               	leaq	0x2(%rdi), %rax
               	movslq	%eax, %rax
               	leaq	-0x30(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm14, 0x10(%rcx)
               	movups	%xmm14, 0x20(%rcx)
               	imulq	$0xc, %rax, %rdx
               	leaq	(%rax,%rax,2), %rax
               	movslq	%eax, %rax
               	shlq	$0x2, %rax
               	cmpq	%rax, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	0x10(%rcx), %rdx
               	movl	$0x7, %eax
               	movl	%eax, 0x8(%rdx)
               	movslq	0x18(%rcx), %rsi
               	cmpl	$0x7, %esi
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	subq	%rcx, %rdx
               	cmpq	$0x10, %rdx
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	xorl	%ecx, %ecx
               	movl	%ecx, -0x8(%rbp)
               	movl	$0x1, %edx
               	movl	%edx, -0x8(%rbp)
               	cmpl	$0x1, %edx
               	jne	<addr>
               	movq	%rcx, %rax
               	leave
               	retq
               	leave
               	retq
