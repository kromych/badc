
slot_coalesce_disjoint_temps.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	xorl	%eax, %eax
               	movq	%rax, %rsi
               	movq	%rax, %rdi
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	testq	%r8, %r8
               	je	<addr>
               	leaq	(%rax,%rax,2), %rcx
               	cmpl	$0xa, %ecx
               	jle	<addr>
               	cmpl	$0x64, %ecx
               	jge	<addr>
               	leaq	-0x1(%rcx), %rdx
               	movslq	%edx, %r9
               	movq	%r9, %rbx
               	shrq	$0x3f, %rbx
               	addq	%rbx, %r9
               	andq	$0x1, %r9
               	subq	%rbx, %r9
               	testl	%r9d, %r9d
               	je	<addr>
               	cmpl	$0x32, %edx
               	jle	<addr>
               	movq	%rdx, %r9
               	shlq	%r9
               	addq	%r9, %rcx
               	addq	%rdx, %rcx
               	addq	%rcx, %rdi
               	testq	%r8, %r8
               	je	<addr>
               	leaq	(%rax,%rax,2), %rcx
               	cmpl	$0xa, %ecx
               	jle	<addr>
               	cmpl	$0x64, %ecx
               	jge	<addr>
               	leaq	-0x1(%rcx), %rdx
               	movslq	%edx, %r8
               	movq	%r8, %r9
               	shrq	$0x3f, %r9
               	addq	%r9, %r8
               	andq	$0x1, %r8
               	subq	%r9, %r8
               	testl	%r8d, %r8d
               	je	<addr>
               	cmpl	$0x32, %edx
               	jle	<addr>
               	movq	%rdx, %r8
               	shlq	%r8
               	jmp	<addr>
               	movq	%rdx, %r8
               	jmp	<addr>
               	leaq	0x1(%rcx), %rdx
               	jmp	<addr>
               	leaq	0x7(%rax), %rcx
               	jmp	<addr>
               	movq	%rdx, %r9
               	jmp	<addr>
               	leaq	0x1(%rcx), %rdx
               	jmp	<addr>
               	leaq	0x7(%rax), %rcx
               	jmp	<addr>
               	addq	%r8, %rcx
               	addq	%rdx, %rcx
               	addq	%rcx, %rsi
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	cmpl	%esi, %edi
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
