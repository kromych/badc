
local_byte_array_init_converts.x64:	file format elf64-x86-64

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
               	leaq	0x8(%rsp), %rdx
               	leaq	<rip>, %rax
               	movl	(%rax), %r10d
               	movl	%r10d, (%rdx)
               	movzbq	0x4(%rax), %r10
               	movb	%r10b, 0x4(%rdx)
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	movzbq	0x8(%rsp,%rax), %rsi
               	movl	$0x1, %edi
               	cmpl	$0x1, %eax
               	cmoveq	%rcx, %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x5, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	addq	$0x18, %rsp
               	retq
               	incq	%rax
               	addq	$0x18, %rsp
               	retq
