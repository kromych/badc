
flex_array_only_member.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	movl	$0x2, %ecx
               	movq	%rcx, 0x8(%rax)
               	movl	$0x3, %ecx
               	movq	%rcx, 0x10(%rax)
               	movl	$0x4, %ecx
               	movq	%rcx, 0x18(%rax)
               	movq	0x10(%rax), %rcx
               	cmpq	$0x3, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	0x18(%rax), %rax
               	cmpq	$0x4, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xf, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	jmp	<addr>
