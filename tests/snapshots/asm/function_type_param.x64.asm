
function_type_param.x64:	file format elf64-x86-64

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

<mixed>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movslq	%edi, %rbx
               	movq	%rdx, %r12
               	movq	%rsi, %rax
               	movq	%rbx, %rdi
               	callq	*%rax
               	leaq	(%rbx,%rax), %r13
               	movq	%r12, %rax
               	movq	%rbx, %rdi
               	callq	*%rax
               	addq	%r13, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<apply1>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movslq	%esi, %rsi
               	movq	%rdi, %rax
               	movq	%rsi, %rdi
               	callq	*%rax
               	movslq	%eax, %rax
               	popq	%rbp
               	retq

<inc>:
               	leaq	0x1(%rdi), %rax
               	movslq	%eax, %rax
               	retq

<neg>:
               	imulq	$-0x1, %rdi, %rax
               	movslq	%eax, %rax
               	retq

<main>:
               	xorl	%eax, %eax
               	retq
