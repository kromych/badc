
volatile_ptr_alias_loop.x64:	file format elf64-x86-64

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
               	xorl	%eax, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	movl	-0x8(%rbp), %ecx
               	incq	%rcx
               	movl	%ecx, -0x8(%rbp)
               	incq	%rax
               	cmpl	$0xa, %eax
               	jg	<addr>
               	movl	-0x8(%rbp), %ecx
               	cmpl	$0x3, %ecx
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x2, %edx
               	cmpl	$0x3, %eax
               	movq	%rdx, %rax
               	cmoveq	%rcx, %rax
               	leave
               	retq
               	movl	$0x1, %eax
               	leave
               	retq
