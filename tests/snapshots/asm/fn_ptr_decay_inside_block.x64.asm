
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
               	movslq	%eax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0xcb, %ebx
               	leaq	-<rip>, %rax       # <addr>
               	jmp	<addr>
               	movl	$0x3, %edi
               	callq	*%rax
               	addq	%rax, %rbx
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-<rip>, %rax       # <addr>
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %rax
               	movl	$0x4, %edi
               	callq	*%rax
               	addq	%rbx, %rax
               	cmpl	$0x19a, %eax            # imm = 0x19A
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %eax
               	jmp	<addr>
