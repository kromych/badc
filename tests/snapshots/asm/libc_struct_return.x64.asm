
libc_struct_return.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	subq	$0x18, %rsp
               	movl	$0x11, %edi
               	movl	$0x5, %esi
               	callq	<addr>
               	movq	%rax, 0x8(%rsp)
               	movl	0x8(%rsp), %eax
               	movl	0xc(%rsp), %ecx
               	leaq	(%rax,%rcx), %rdx
               	cmpl	$0x5, %edx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x18, %rsp
               	retq
               	imulq	%rcx, %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x64, %edi
               	movl	$0x7, %esi
               	callq	<addr>
               	movq	%rax, 0x8(%rsp)
               	movl	0x8(%rsp), %eax
               	movl	0xc(%rsp), %ecx
               	addq	%rcx, %rax
               	cmpl	$0x10, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x18, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x18, %rsp
               	retq
