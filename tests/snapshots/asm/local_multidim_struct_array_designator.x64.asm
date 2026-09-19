
local_multidim_struct_array_designator.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax
               	movslq	0x18(%rax), %rcx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movslq	0x1c(%rax), %rcx
               	cmpl	$0x4, %ecx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movslq	(%rax), %rcx
               	cmpl	$0x9, %ecx
               	jne	<addr>
               	movslq	0x4(%rax), %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movslq	0x8(%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movslq	0x14(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	xorq	%rax, %rax
               	retq
