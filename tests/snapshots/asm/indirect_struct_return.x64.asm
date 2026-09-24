
indirect_struct_return.x64:	file format elf64-x86-64

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

<make>:
               	movq	%rdi, %rax
               	shlq	%rax
               	movl	%edi, %ecx
               	movl	%eax, %eax
               	shlq	$0x20, %rax
               	orq	%rcx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0xa, %edi
               	callq	<addr>
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movl	(%rax), %ecx
               	movl	0x4(%rax), %eax
               	cmpl	$0xa, %ecx
               	jne	<addr>
               	cmpl	$0x14, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	addq	$0x3, %rax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
