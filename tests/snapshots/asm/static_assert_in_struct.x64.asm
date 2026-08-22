
static_assert_in_struct.x64:	file format elf64-x86-64

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
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	xorq	%rbx, %rbx
               	movq	%rbx, %rax
               	leaq	<rip>, %rdi
               	movl	$0x1, %esi
               	movl	$0x2, %edx
               	movl	$0x8, %ecx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rbx, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
