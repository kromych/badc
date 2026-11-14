
scanf_fscanf_binding.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x0, -0x10(%rbp)
               	movl	$0x0, -0x8(%rbp)
               	cmpl	$0x1869f, %edi          # imm = 0x1869F
               	jle	<addr>
               	leaq	<rip>, %rdi
               	leaq	-0x10(%rbp), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	leaq	<rip>, %rsi
               	leaq	-0x8(%rbp), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movl	-0x10(%rbp), %eax
               	movl	-0x8(%rbp), %ecx
               	addq	%rcx, %rax
               	leave
               	retq
