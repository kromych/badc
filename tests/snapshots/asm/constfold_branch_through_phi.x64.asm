
constfold_branch_through_phi.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<widened>:
               	movl	$0x1, %eax
               	leaq	0x1(%rdi), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x1, %eax
               	movl	$0x8, %eax
               	movl	$0x1, %eax
               	movl	$0x2, %eax
               	movl	$0xa, %eax
               	movl	$0x64, %eax
               	movl	$0x8, %eax
               	movl	$0xa, %eax
               	movl	$0x64, %eax
               	movabsq	$-0x2, %rax
               	movl	$0x9, %edi
               	callq	<addr>
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
