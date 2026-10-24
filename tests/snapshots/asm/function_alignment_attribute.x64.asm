
function_alignment_attribute.x64:	file format elf64-x86-64

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
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop

<f64>:
               	movl	$0x1, %eax
               	retq
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop

<s128>:
               	leaq	0x1(%rdi), %rax
               	retq
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop

<h>:
               	movl	$0x3, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%rbx
               	leaq	-<rip>, %rax       # <addr>
               	movq	%rax, -0x18(%rbp)
               	leaq	-<rip>, %rax       # <addr>
               	movq	%rax, -0x10(%rbp)
               	leaq	-<rip>, %rax       # <addr>
               	movq	%rax, -0x8(%rbp)
               	movq	-0x10(%rbp), %rax
               	testb	$0x3f, %al
               	jne	<addr>
               	movq	-0x18(%rbp), %rax
               	testb	$0x7f, %al
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	testb	$0x1f, %al
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %edi
               	movq	-0x18(%rbp), %rax
               	callq	*%rax
               	movq	%rax, %rbx
               	movq	-0x10(%rbp), %rax
               	callq	*%rax
               	addq	%rax, %rbx
               	movq	-0x8(%rbp), %rax
               	callq	*%rax
               	addq	%rbx, %rax
               	addq	$0x2, %rax
               	cmpl	$0x8, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2, %eax
               	jmp	<addr>
