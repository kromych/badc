
function_returning_pointer_to_array.x64:	file format elf64-x86-64

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

<half>:
               	movsd	<rip>, %xmm1
               	divsd	%xmm1, %xmm0
               	retq

<twice>:
               	movq	%rdi, %rax
               	shlq	%rax
               	retq

<mki>:
               	leaq	<rip>, %rax # <addr>
               	retq

<mkf>:
               	leaq	<rip>, %rax # <addr>
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x6, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movsd	<rip>, %xmm0
               	callq	*%rax
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movl	$0x4, %edi
               	callq	<addr>
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbp
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x7, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
               	movl	$0xa, %eax
               	popq	%rbp
               	retq
               	movl	$0x8, %eax
               	popq	%rbp
               	retq
               	movl	$0x3, %eax
               	popq	%rbp
               	retq

<mkl>:
               	leaq	<rip>, %rax # <addr>
               	retq

<sig>:
               	testl	%edi, %edi
               	je	<addr>
               	leaq	-<rip>, %rax # <addr>
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>
