
function_typed_parameter.x64:	file format elf64-x86-64

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

<apply>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movslq	%esi, %rsi
               	movq	%rdi, %rax
               	movq	%rsi, %rdi
               	callq	*%rax
               	movslq	%eax, %rax
               	popq	%rbp
               	retq

<apply_bare>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movslq	%esi, %rsi
               	movq	%rdi, %rax
               	movq	%rsi, %rdi
               	callq	*%rax
               	movslq	%eax, %rax
               	popq	%rbp
               	retq

<passthrough>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movslq	%esi, %rsi
               	movq	%rdi, %rax
               	movq	%rsi, %rdi
               	callq	*%rax
               	popq	%rbp
               	retq

<doubler>:
               	movq	%rdi, %rax
               	shlq	%rax
               	movslq	%eax, %rax
               	retq

<take_slot>:
               	movslq	%edi, %rdi
               	leaq	<rip>, %rax
               	movq	%rdi, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	retq

<plain_func>:
               	leaq	0x1(%rdi), %rax
               	movslq	%eax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-<rip>, %rbx       # <addr>
               	movl	$0x15, %edi
               	movq	%rbx, %rax
               	callq	*%rax
               	movslq	%eax, %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	-<rip>, %rax       # <addr>
               	movl	$0xa, %edi
               	callq	*%rax
               	movslq	%eax, %rax
               	cmpq	$0xb, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	-<rip>, %rax       # <addr>
               	movl	$0x3, %edi
               	callq	*%rax
               	leaq	<rip>, %rcx
               	addq	$0xc, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x10, %edi
               	movq	%rbx, %rax
               	callq	*%rax
               	movslq	%eax, %rax
               	cmpq	$0x20, %rax
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
