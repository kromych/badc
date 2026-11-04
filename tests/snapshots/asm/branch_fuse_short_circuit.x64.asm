
branch_fuse_short_circuit.x64:	file format elf64-x86-64

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
               	movslq	<rip>, %rax # <addr>
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rdx # <addr>
               	movl	<rip>, %esi # <addr>
               	cmpq	$-0x1, %rcx
               	jne	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	testq	%rdx, %rdx
               	jne	<addr>
               	testl	%esi, %esi
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	movl	<rip>, %ecx # <addr>
               	cmpq	$0x64, %rax
               	jbe	<addr>
               	movq	<rip>, %rax # <addr>
               	movl	<rip>, %eax # <addr>
               	movq	<rip>, %rax # <addr>
               	movl	<rip>, %ecx # <addr>
               	cmpq	$0x64, %rax
               	jbe	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	$0x64, %rax
               	jbe	<addr>
               	xorl	%eax, %eax
               	retq
               	movl	$0x5, %eax
               	retq
               	movl	$0x4, %eax
               	retq
               	movl	$0x2, %eax
               	retq
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>
