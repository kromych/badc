
fn_ptr_decay_inside_block.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<adder>:
               	leaq	0x64(%rdi), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	-<rip>, %rbx       # <addr>
               	movl	$0x1, %edi
               	movq	%rbx, %rax
               	callq	*%rax
               	leaq	(%rax), %r12
               	movl	$0x2, %edi
               	movq	%rbx, %rax
               	callq	*%rax
               	leaq	(%r12,%rax), %rbx
               	leaq	-<rip>, %rax       # <addr>
               	jmp	<addr>
               	movl	$0x3, %edi
               	callq	*%rax
               	addq	%rax, %rbx
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-<rip>, %rax       # <addr>
               	movq	%rax, -0x48(%rbp)
               	leaq	-0x48(%rbp), %rax
               	movq	(%rax), %rax
               	movl	$0x4, %edi
               	callq	*%rax
               	addq	%rbx, %rax
               	movslq	%eax, %rax
               	cmpq	$0x19a, %rax            # imm = 0x19A
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %eax
               	jmp	<addr>
