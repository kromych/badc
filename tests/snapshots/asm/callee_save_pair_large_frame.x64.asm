
callee_save_pair_large_frame.x64:	file format elf64-x86-64

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

<sink>:
               	xorl	%eax, %eax
               	testl	%edi, %edi
               	jle	<addr>
               	leaq	-0x1(%rdi), %rcx
               	addq	%rdi, %rax
               	movq	%rcx, %rdi
               	testl	%edi, %edi
               	jg	<addr>
               	incq	%rax
               	retq

<bigframe>:
               	pushq	%rax
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	movq	%rbx, %rdi
               	callq	<addr>
               	addq	%r12, %rax
               	addq	%rbx, %rax
               	addq	%r12, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r11
               	retq

<main>:
               	movl	$0x3, %edi
               	movl	$0x4, %esi
               	jmp	<addr>
