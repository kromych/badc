
typedef_fn_ptr_struct_field.x64:	file format elf64-x86-64

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

<doer>:
               	movq	%rdi, %rax
               	imulq	%rsi, %rax
               	movslq	%eax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-<rip>, %rbx       # <addr>
               	movl	$0x3, %edi
               	movl	$0x7, %esi
               	movq	%rbx, %rax
               	callq	*%rax
               	movslq	%eax, %rax
               	cmpq	$0x15, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x4, %edi
               	movl	$0x5, %esi
               	movq	%rbx, %rax
               	callq	*%rax
               	movslq	%eax, %rax
               	cmpq	$0x14, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %edi
               	movl	$0x9, %esi
               	movq	%rbx, %rax
               	callq	*%rax
               	movslq	%eax, %rax
               	cmpq	$0x12, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x6, %edi
               	movl	$0x4, %esi
               	movq	%rbx, %rax
               	callq	*%rax
               	movslq	%eax, %rax
               	cmpq	$0x18, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
