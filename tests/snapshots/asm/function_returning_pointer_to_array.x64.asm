
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
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm15
               	divsd	%xmm15, %xmm0
               	retq

<twice>:
               	movq	%rdi, %rax
               	shlq	%rax
               	retq

<mki>:
               	leaq	<rip>, %rax      # <addr>
               	retq

<mkf>:
               	leaq	<rip>, %rax      # <addr>
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rax      # <addr>
               	movslq	0x4(%rax), %rax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movslq	0x14(%rax), %rax
               	cmpl	$0x6, %eax
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movq	0x8(%rax), %rax
               	movabsq	$0x4010000000000000, %rcx # imm = 0x4010000000000000
               	movq	%rcx, %xmm0
               	callq	*%rax
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	movslq	(%rax), %rax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movslq	(%rax), %rax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movslq	0x8(%rax), %rax
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movl	$0x4, %edi
               	callq	<addr>
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movslq	(%rax), %rax
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
               	leaq	<rip>, %rax      # <addr>
               	retq

<sig>:
               	movslq	%edi, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	leaq	-<rip>, %rax      # <addr>
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>
