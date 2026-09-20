
struct_by_value_param.x64:	file format elf64-x86-64

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

<sum_pair>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	movslq	(%rcx), %rax
               	movslq	0x4(%rcx), %rdx
               	addq	%rdx, %rax
               	movl	$0xffffffff, (%rcx)     # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x4(%rcx)  # imm = 0xFFFFFFFF
               	leave
               	retq

<main>:
               	xorl	%eax, %eax
               	retq
