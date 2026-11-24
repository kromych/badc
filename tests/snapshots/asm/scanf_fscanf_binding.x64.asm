
scanf_fscanf_binding.x64:	file format elf64-x86-64

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

<main>:
               	subq	$0x18, %rsp
               	movl	$0x0, (%rsp)
               	movl	$0x0, 0x8(%rsp)
               	cmpl	$0x1869f, %edi          # imm = 0x1869F
               	jle	<addr>
               	leaq	<rip>, %rdi
               	leaq	(%rsp), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	leaq	<rip>, %rsi
               	leaq	0x8(%rsp), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movl	(%rsp), %eax
               	movl	0x8(%rsp), %ecx
               	addq	%rcx, %rax
               	addq	$0x18, %rsp
               	retq
