
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
               	movslq	%eax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	jmp	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-<rip>, %rcx       # <addr>
               	jmp	<addr>
               	leaq	-<rip>, %rbx       # <addr>
               	movl	$0x1, %edi
               	movq	%rbx, %rax
               	callq	*%rax
               	leaq	(%rax), %r12
               	movl	$0x2, %edi
               	movq	%rbx, %rax
               	callq	*%rax
               	leaq	(%r12,%rax), %rbx
               	jmp	<addr>
               	testq	%rcx, %rcx
               	je	<addr>
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x3, %edi
               	movq	%rcx, %rax
               	callq	*%rax
               	addq	%rax, %rbx
               	jmp	<addr>
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
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x2, %ecx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
