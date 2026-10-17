
thread_local_reads_a_code_slot.x64:	file format elf64-x86-64

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

<fb>:
               	movl	$0x2, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%fs:0x0, %rax
               	addq	$-0x10, %rax
               	movq	(%rax), %rcx
               	leaq	-<rip>, %rdx       # <addr>
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	leaq	-<rip>, %rax       # <addr>
               	movq	%fs:0x0, %rcx
               	addq	$-0x8, %rcx
               	movq	(%rcx), %rcx
               	subq	%rcx, %rax
               	cmpq	$0x186a0, %rax          # imm = 0x186A0
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
               	movl	$0x2, %eax
               	jmp	<addr>
