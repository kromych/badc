
bound_import_arg_narrowing.x64:	file format elf64-x86-64

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
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rdi)
               	movl	$0x141, %esi            # imm = 0x141
               	movl	$0x3, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movsbq	-0x8(%rbp), %rax
               	cmpl	$0x41, %eax
               	jne	<addr>
               	movsbq	-0x7(%rbp), %rax
               	cmpl	$0x41, %eax
               	jne	<addr>
               	movsbq	-0x6(%rbp), %rax
               	cmpl	$0x41, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movsbq	-0x5(%rbp), %rax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
