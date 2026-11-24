
file_io.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	pushq	%rbx
               	leaq	<rip>, %rdi
               	xorl	%esi, %esi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %rbx
               	testl	%ebx, %ebx
               	jge	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	addq	$0x20, %rsp
               	retq
               	movl	$0xa, %edi
               	callq	<addr>
               	movq	%rax, %rcx
               	movl	$0x9, %edx
               	movq	%rcx, 0x18(%rsp)
               	movq	%rbx, %rdi
               	movq	%rcx, %rsi
               	callq	<addr>
               	movq	0x18(%rsp), %rcx
               	movb	$0x0, 0x9(%rcx)
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	addq	$0x20, %rsp
               	retq
