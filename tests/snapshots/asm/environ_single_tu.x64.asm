
environ_single_tu.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x1, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x0, (%rax)
               	je	<addr>
               	incq	%rcx
               	addq	$0x8, %rax
               	cmpq	$0x0, (%rax)
               	jne	<addr>
               	testl	%ecx, %ecx
               	jle	<addr>
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
