
cast_to_union_initializes_its_member.x64:	file format elf64-x86-64

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
               	movb	$0x78, -0x8(%rbp)
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	movq	%rax, %rdx
               	shlq	%rdx
               	addq	%rdx, %rcx
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	movsbq	-0x8(%rbp), %rax
               	cmpl	$0x6, %ecx
               	jne	<addr>
               	cmpl	$0x78, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
