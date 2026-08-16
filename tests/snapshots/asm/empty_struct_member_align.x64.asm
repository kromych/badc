
empty_struct_member_align.x64:	file format elf64-x86-64

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
               	subq	$0x80, %rsp
               	subq	$0x80, %rsp
               	andq	$-0x40, %rsp
               	leaq	(%rsp), %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	leaq	(%rsp), %rax
               	movl	$0x2, %ecx
               	movq	%rcx, 0x40(%rax)
               	leaq	(%rsp), %rax
               	addq	$0x40, %rax
               	leaq	(%rsp), %rcx
               	subq	%rcx, %rax
               	cmpq	$0x40, %rax
               	je	<addr>
               	movl	$0x12, %eax
               	leaq	-0x80(%rbp), %rsp
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	leaq	-0x80(%rbp), %rsp
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
