
volatile_ptr_alias_loop.x64:	file format elf64-x86-64

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
               	xorl	%eax, %eax
               	movl	%eax, 0x8(%rsp)
               	jmp	<addr>
               	movl	0x8(%rsp), %ecx
               	incq	%rcx
               	movl	%ecx, 0x8(%rsp)
               	incq	%rax
               	nopw	(%rax,%rax)
               	cmpl	$0xa, %eax
               	jg	<addr>
               	movl	0x8(%rsp), %ecx
               	cmpl	$0x3, %ecx
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x2, %edx
               	cmpl	$0x3, %eax
               	movq	%rdx, %rax
               	cmoveq	%rcx, %rax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x1, %eax
               	addq	$0x18, %rsp
               	retq
