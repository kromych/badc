
function_alignment_attribute.x64:	file format elf64-x86-64

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
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<first>:
               	movl	$0x2, %eax
               	retq

<f64>:
               	movl	$0x1, %eax
               	retq

<s128>:
               	leaq	0x1(%rdi), %rax
               	retq

<h>:
               	movl	$0x3, %eax
               	retq

<main>:
               	subq	$0x38, %rsp
               	leaq	-<rip>, %rax # <addr>
               	movq	%rax, 0x18(%rsp)
               	leaq	-<rip>, %rax # <addr>
               	movq	%rax, 0x20(%rsp)
               	leaq	-<rip>, %rax # <addr>
               	movq	%rax, 0x28(%rsp)
               	movq	0x20(%rsp), %rax
               	testb	$0x3f, %al
               	jne	<addr>
               	movq	0x18(%rsp), %rax
               	testb	$0x7f, %al
               	jne	<addr>
               	movq	0x28(%rsp), %rax
               	testb	$0x1f, %al
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x38, %rsp
               	retq
               	movq	0x18(%rsp), %rax
               	movl	$0x1, %edi
               	callq	*%rax
               	movq	%rax, 0x8(%rsp)
               	movq	0x20(%rsp), %rax
               	callq	*%rax
               	movq	0x8(%rsp), %r10
               	addq	%rax, %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x28(%rsp), %rax
               	callq	*%rax
               	movq	%rax, %r10
               	movq	0x8(%rsp), %rax
               	addq	%r10, %rax
               	addq	$0x2, %rax
               	xorl	%ecx, %ecx
               	movl	$0x2, %edx
               	cmpl	$0x8, %eax
               	cmovneq	%rdx, %rcx
               	movq	%rcx, %rax
               	addq	$0x38, %rsp
               	retq
