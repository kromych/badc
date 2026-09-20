
nested_runtime_init.x64:	file format elf64-x86-64

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
               	xorl	%eax, %eax
               	leaq	0x1(%rax), %rcx
               	cmpl	%eax, %eax
               	jne	<addr>
               	cmpl	%ecx, %ecx
               	jne	<addr>
               	movq	%rax, %rdx
               	shlq	%rdx
               	leaq	0x3(%rax), %rsi
               	cmpl	%edx, %edx
               	jne	<addr>
               	cmpl	%esi, %esi
               	jne	<addr>
               	leaq	0x5(%rax), %rdx
               	cmpl	%edx, %edx
               	jne	<addr>
               	addq	$0x2, %rax
               	cmpl	%ecx, %ecx
               	jne	<addr>
               	cmpl	%eax, %eax
               	jne	<addr>
               	movq	%rcx, %rax
               	cmpl	$0x14, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	retq
               	movl	$0x4, %eax
               	retq
               	movl	$0x3, %eax
               	retq
               	movl	$0x2, %eax
               	retq
               	movl	$0x1, %eax
               	retq
