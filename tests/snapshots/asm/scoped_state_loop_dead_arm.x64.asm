
scoped_state_loop_dead_arm.x64:	file format elf64-x86-64

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

<work>:
               	movq	<rip>, %rax # <addr>
               	addq	%rdi, %rax
               	movq	%rax, <rip> # <addr>
               	retq

<main>:
               	xorl	%edx, %edx
               	movl	$0x3, %ecx
               	movq	<rip>, %rax # <addr>
               	movq	%rdx, %rsi
               	movq	<rip>, %rdi # <addr>
               	addq	%rax, %rdi
               	movq	%rdi, <rip> # <addr>
               	incq	%rsi
               	cmpl	$0x2, %ecx
               	jb	<addr>
               	cmpl	$0x3, %ecx
               	jb	<addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	jmp	<addr>
               	movq	%rdx, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	cmpq	$0x1, %rsi
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	xorl	%eax, %eax
               	retq
