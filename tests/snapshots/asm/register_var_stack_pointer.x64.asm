
register_var_stack_pointer.x64:	file format elf64-x86-64

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

<read_sp>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%rsp, %rax
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	callq	<addr>
               	movq	%rax, %rbx
               	callq	<addr>
               	movq	%rax, %rdx
               	movq	%rbp, %rcx
               	testq	%rbx, %rbx
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rbx, %rbx
               	je	<addr>
               	testq	%rcx, %rcx
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	cmpq	%rdx, %rbx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	cmpq	%rbx, %rcx
               	jae	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	jmp	<addr>
