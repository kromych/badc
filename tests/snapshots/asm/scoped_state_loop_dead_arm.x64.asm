
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
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rcx
               	addq	%rdi, %rcx
               	movq	%rcx, (%rax)
               	retq

<main>:
               	xorl	%edx, %edx
               	movl	$0x3, %ecx
               	leaq	<rip>, %r8 # <addr>
               	movq	(%r8), %rax
               	leaq	<rip>, %rdi # <addr>
               	movq	%rdx, %rsi
               	movq	(%rdi), %r9
               	addq	%rax, %r9
               	movq	%r9, (%rdi)
               	incq	%rsi
               	cmpl	$0x2, %ecx
               	jb	<addr>
               	cmpl	$0x3, %ecx
               	jb	<addr>
               	movq	(%r8), %rcx
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
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	xorl	%eax, %eax
               	retq
