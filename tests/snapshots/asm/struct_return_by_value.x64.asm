
struct_return_by_value.x64:	file format elf64-x86-64

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

<echo_small>:
               	movq	%rdi, %rax
               	shrq	$0x20, %rax
               	movl	%edi, %ecx
               	shlq	$0x20, %rax
               	orq	%rcx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x7, %eax
               	leaq	-0x10(%rbp), %rdi
               	movl	%eax, (%rdi)
               	movl	$0x8, 0x4(%rdi)
               	cmpl	$0x7, %eax
               	jne	<addr>
               	movslq	0x4(%rdi), %rax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movl	(%rax), %ecx
               	movl	0x4(%rax), %eax
               	cmpl	$0x7, %ecx
               	jne	<addr>
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
