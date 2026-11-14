
param_named_like_function.x64:	file format elf64-x86-64

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

<gp>:
               	movss	<rip>, %xmm1
               	mulss	%xmm1, %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	retq

<tfi>:
               	leaq	(%rdi,%rdi,2), %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x62, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movl	$0x6, %edi
               	callq	<addr>
               	cmpl	$0x12, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
