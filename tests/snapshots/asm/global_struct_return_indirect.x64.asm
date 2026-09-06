
global_struct_return_indirect.x64:	file format elf64-x86-64

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
               	movl	(%rax), %ecx
               	movl	0x4(%rax), %edx
               	movl	0x10(%rax), %esi
               	movl	%ecx, %edi
               	movl	%edx, %ecx
               	movl	%esi, %edx
               	movl	%edi, %esi
               	xorq	$0x1, %rsi
               	movl	%esi, %esi
               	testq	%rsi, %rsi
               	jne	<addr>
               	cmpl	$0x2, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	cmpl	$0x5, %edx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	(%rax), %ecx
               	movl	%ecx, %ecx
               	movl	0x10(%rax), %eax
               	addq	%rcx, %rax
               	movl	%eax, %eax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	xorq	%rax, %rax
               	retq
