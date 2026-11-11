
fn_ptr_decay_inside_block.x64:	file format elf64-x86-64

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

<adder>:
               	leaq	0x64(%rdi), %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	movl	$0x3, %edi
               	callq	<addr>
               	leaq	0xcb(%rax), %rbx
               	leaq	-<rip>, %rax # <addr>
               	movq	%rax, -0x8(%rbp)
               	movl	$0x4, %edi
               	callq	<addr>
               	addq	%rbx, %rax
               	xorl	%ecx, %ecx
               	movl	$0x2, %edx
               	cmpl	$0x19a, %eax            # imm = 0x19A
               	movq	%rdx, %rax
               	cmoveq	%rcx, %rax
               	popq	%rbx
               	leave
               	retq
