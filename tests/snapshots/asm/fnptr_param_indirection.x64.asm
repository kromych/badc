
fnptr_param_indirection.x64:	file format elf64-x86-64

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

<inc>:
               	leaq	0x1(%rdi), %rax
               	retq

<dbl>:
               	movq	%rdi, %rax
               	shlq	%rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0xa, %edi
               	callq	<addr>
               	cmpl	$0xb, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbp
               	retq
               	movl	$0xa, %edi
               	callq	<addr>
               	cmpl	$0x14, %eax
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbp
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
