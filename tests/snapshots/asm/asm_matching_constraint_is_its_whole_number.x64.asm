
asm_matching_constraint_is_its_whole_number.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%eax, %eax
               	movl	$0x1, %ecx
               	movl	$0x2, %edx
               	movl	$0x3, %esi
               	movl	$0x4, %edi
               	movl	$0x5, %r8d
               	movl	$0x6, %r9d
               	movl	$0x7, %ebx
               	movl	$0x8, %r12d
               	movl	$0x9, %r13d
               	movq	%rbx, %r10
               	movq	%r12, %r11
               	movq	%r13, %rbx
               	movl	$0x2a, %r12d
               	cmpq	$0x2a, %r12
               	jne	<addr>
               	cmpq	$0x1, %rcx
               	jne	<addr>
               	cmpq	$0x9, %rbx
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
