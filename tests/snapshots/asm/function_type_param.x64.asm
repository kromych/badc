
function_type_param.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rdx, %r12
               	movq	%rbx, %rdi
               	callq	*%rsi
               	leaq	(%rbx,%rax), %r13
               	movq	%rbx, %rdi
               	callq	*%r12
               	addq	%r13, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	retq

<apply1>:
               	pushq	%rax
               	movq	%rdi, %rax
               	movq	%rsi, %rdi
               	callq	*%rax
               	popq	%r11
               	retq

<inc>:
               	leaq	0x1(%rdi), %rax
               	retq

<neg>:
               	movq	%rdi, %rax
               	negq	%rax
               	retq

<main>:
               	xorl	%eax, %eax
               	retq
