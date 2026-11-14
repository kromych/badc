
typeof_function_types.x64:	file format elf64-x86-64

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

<twice>:
               	movq	%rdi, %rax
               	shlq	%rax
               	retq

<half>:
               	movsd	<rip>, %xmm1
               	divsd	%xmm1, %xmm0
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x5, %edi
               	callq	<addr>
               	cmpl	$0xa, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movl	$0x7, %edi
               	callq	*%rax
               	cmpl	$0xe, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
