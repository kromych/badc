
tailrec_narrow_result_accumulates.x64:	file format elf64-x86-64

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

<fib_int>:
               	cmpl	$0x2, %edi
               	jl	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	xorl	%r12d, %r12d
               	leaq	-0x1(%rbx), %rdi
               	callq	<addr>
               	subq	$0x2, %rbx
               	addq	%rax, %r12
               	cmpl	$0x2, %ebx
               	jge	<addr>
               	leaq	(%r12,%rbx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movslq	%edi, %rax
               	retq

<golden_sum>:
               	movl	$0x64, %ecx
               	movl	$0x9e3779b9, %edx       # imm = 0x9E3779B9
               	xorl	%eax, %eax
               	decq	%rcx
               	addq	%rdx, %rax
               	testl	%ecx, %ecx
               	jne	<addr>
               	retq

<down_long>:
               	movl	$0xa, %eax
               	xorl	%ecx, %ecx
               	decq	%rax
               	addq	$-0x3, %rcx
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	0x64(%rcx), %rax
               	retq

<times3_short>:
               	movl	$0xc, %ecx
               	movl	$0x1, %eax
               	decq	%rcx
               	leaq	(%rax,%rax,2), %rax
               	movswq	%ax, %rax
               	testl	%ecx, %ecx
               	jne	<addr>
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	xorl	%eax, %eax
               	movl	$0x9e3779b9, %ecx       # imm = 0x9E3779B9
               	movq	%rax, %rbx
               	addq	%rcx, %rbx
               	incq	%rax
               	cmpl	$0x64, %eax
               	jl	<addr>
               	movl	$0x18, %edi
               	callq	<addr>
               	cmpl	$0xb520, %eax           # imm = 0xB520
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x64, %edi
               	callq	<addr>
               	cmpl	%ebx, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xa, %edi
               	callq	<addr>
               	cmpq	$0x46, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xc, %edi
               	callq	<addr>
               	movswq	%ax, %rax
               	cmpl	$0x1bf1, %eax           # imm = 0x1BF1
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
