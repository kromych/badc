
thread_local_slot_escapes_a_function.x64:	file format elf64-x86-64

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

<twice>:
               	shlq	%rdi
               	movq	%rdi, %rax
               	retq

<main>:
               	pushq	%rbx
               	movl	$0x5, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x7, %edi
               	movq	%fs:0x0, %rax
               	addq	$-0x8, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpl	$0xa, %ebx
               	jne	<addr>
               	cmpl	$0xe, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
